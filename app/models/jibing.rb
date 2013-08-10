#encoding: utf-8
class Jibing < ActiveRecord::Base
  attr_accessible :name,:items_count
  has_many :ji_items,:include=>:drug
  has_many :drugs,:through=>:ji_items,:uniq=>true
  def add_drug drug
    JiItem.where(:jibing_id=>id,:drug_id => drug.id).first_or_create
  end
  def self.init_all_items
    where('items_count < 2').find_each do |r|
      pp r
      r.suggest
      sleep 1
    end
  end
  def suggest
    q = ActiveSupport::JSON::Encoding.escape(name).gsub(/\"/,'').gsub("\\",'%')
    url = 'http://ypk.39.net/search/all'
    agents = [
      'Mozilla/5.0 (MSIE 9.0; Windows NT 6.1; Trident/5.0)',
      'Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_2 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8H7 Safari/6533.18.5'
    
    ]

    items = {}
    for i in 1..3
      response = Typhoeus::Request.get url + "?k=" + CGI.escape(q),
          :headers=>{"User-Agent" => agents.sample},:follow_location=>true
      if response.success?
        body = response.body.encode("UTF-8","GBK") rescue response.body
        doc = Nokogiri::HTML(body)
        doc.css('#con_main_ul li').each do |li|
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
            add_drug drug if item[:desc].match(name).present?

            #pp item[:desc],name,item[:desc].match(name)
          end
          item[:drug] = drug
          items[drug_name] = item
        end
        break
      else
        Rails.logger.debug response.inspect
        #retry
      end
      sleep 1
    end
    items
  end
  #class Aizhan
    #def self.list
      #base = 'http://ci.aizhan.com/%E5%90%83%E4%BB%80%E4%B9%88%E8%8D%AF/'
      #i = 1
      #pages = 1
      #begin
        #url = "#{base}/#{i}/"
        #response = Typhoeus::Request.get url
        #doc = Nokogiri::HTML(response.body)
        #doc.at_css('.pages').previous_element().css('tr td.blue a').each do |a|
          #pp a.text()
        #end
        #if i == 1
          #pp doc.css('.pages a').last().text()
        #end
      #end while i < pages
    #end
  #end
end
