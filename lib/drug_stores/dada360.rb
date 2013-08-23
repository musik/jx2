#encoding: utf-8
module DrugStores
  class Dada360 < Base
    @queue = 'stores_search'
    def self.perform name
      self.new.search name
    end
    def async_search name
      Resque.enqueue(Dada360,name)
    end
    def search name
      url = "http://www.dada360.com/search?q=#{CGI.escape name}"
      doc = fetch_page url 
      hrefs = []
      doc.css("#data-list .name a").each do |a|
        hrefs << "http://www.dada360.com" + a.attr("href")
      end
      if hrefs.present?
        hrefs.uniq.each do |url|
          parse_item url
        end
      end
    end
    def parse_item url
      doc = fetch_page url
      wenhao = doc.at_css('#form-area tr').text.match(/批准文号：(国药.字[A-Z0-9]+)/)[1] rescue nil
      if wenhao.present?
        yaopin = Yaopin.find wenhao
        if yaopin.present?
          price = doc.at_css('#vip-price').text.to_f
          title = doc.at_css('h1').text
          url = url.match(/(\d+)\.html/)[1]
          conditions = {url: url, scope: 'dada360'}
          e = yaopin.items.where(conditions).first
          hash = {
            price: price,
            title: title
          }
          if e.present?
            e.update_attributes hash
            else
            yaopin.items.create hash.merge(conditions)
            description = doc.at_css('#table-descip').text.gsub(/\r\n/,'').match(/适应症】(.+?)【/)[1].strip rescue nil
            if description.present?
              drug = yaopin.drug
              drug.update_attribute :description,description if drug.description.nil?
            end
          end
        end
      end
    end
  end
end
