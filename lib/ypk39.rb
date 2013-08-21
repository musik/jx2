# -*- encoding : utf-8 -*-
class Ypk39
  @queue = 'stores_search'
  def self.perform
    self.new.run
  end
  def self.async_run
    Resque.enqueue Ypk39
  end
  def run
    i = 1
    begin 
      begin
        run_page i
      rescue Exception=>e
        Rails.logger.info "ERROR:YPK39.run_page #{i} failed #{e.inspect}" unless @success
      end
      i += 1
      sleep 1
    end while has_next_page?
  end
  def run_page page = 1
    agents = [
      'Mozilla/5.0 (MSIE 9.0; Windows NT 6.1; Trident/5.0)',
      'Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_2 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8H7 Safari/6533.18.5'
    
    ]

    @success = false
    items = {}
    for i in 1..5
      response  = Typhoeus::Request.get "http://ypk.39.net/search/all/0-0-0-0-0-1-9-9-0-#{page}/",
            :headers=>{"User-Agent" => agents.sample},:follow_location=>true
      Rails.logger.info "YPK39.URL " + response.effective_url
      if response.success?
        body = response.body.encode("UTF-8","GBK",:invalid=>:replace,:undef=>:replace,:replace=>'?')
        @doc = Nokogiri::HTML(body)
        @doc.css('#con_main_ul li').each do |li|
          next if li.at_css('h4 a').nil?
          drug_name = li.at_css('h4 a').text().strip
          if match = drug_name.match(/[\(（](.+)[\)）]/) and match.present?
            drug_name = match[1]
          end
          next if items.has_key? drug_name 
          item = {:name=>drug_name}
          item[:desc] = li.at_css('.con_main_mid p').text().strip.gsub(/^[\s　]+/,'')
          drug =  Drug.find_by_name drug_name
          if drug.present?
            drug.update_attribute :description,item[:desc] if drug.description.nil?
          end
          item[:drug] = drug
          items[drug_name] = item
        end
        @success = true
        break
      else
        #Rails.logger.info "ERROR:YPK39.run_page #{page} retry #{response.inspect}"
      end
      sleep i
    end
    raise "retried 3 times" unless @success
    items
  end
  def has_next_page?
    @doc.at_css('.pages a.next').present?
  end
end
