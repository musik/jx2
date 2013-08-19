#encoding: utf-8
module DrugStores
  class Kad < Base
    @queue = 'stores_search'
    def self.perform name
      self.new.search name
    end
    def async_search name
      Resque.enqueue(Kad,name)
    end
    def search name
      url = "http://search.360kad.com/?pageText=#{CGI.escape name}"
      doc = fetch_page url 
      hrefs = []
      doc.css(".Product_Show li .t a").each do |a|
        hrefs << a.attr("href").match(/^(.+?)\?/)[1]
      end
      if hrefs.present?
        hrefs.uniq.each do |url|
          parse_item(url) rescue nil
        end
      end
    end
    def parse_item url
      doc = fetch_page url
      wenhao = doc.at_css('.prodetail01').text.match(/批准文号：(国药.字[A-Z0-9]+)/)[1] rescue nil
      if wenhao.present?
        yaopin = Yaopin.find wenhao
        #pp url
        if yaopin.present?
          price = doc.at_css('#pricenumber').text.gsub(/[￥¥,]/,'').to_f
          title = doc.at_css('h1').text
          url = url.match(/product\/(\d+)/)[1]
          conditions = {url: url, scope: 'kad'}
          e = yaopin.items.where(conditions).first
          hash = {
            price: price,
            title: title
          }
          if e.present?
            e.update_attributes hash
            else
            yaopin.items.create hash.merge(conditions)
            description = doc.at_css('.prodetail01').text.match(/功能主治：(.+)/)[1].strip rescue nil
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
