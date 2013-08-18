#encoding: utf-8
module DrugStores
  class Jxdyf < Base
    def async_search name
      Resque.enqueue(JxdyfJob,name)
    end
    def search name
      url = "http://www.jxdyf.com/search-#{CGI.escape name}.html"
      doc = fetch_page url 
      hrefs = []
      doc.css("#shop-comm-list li h3 a").each do |a|
        hrefs << "http://www.jxdyf.com" + a.attr("href")
      end
      if hrefs.present?
        hrefs.uniq.each do |url|
          parse_item url
        end
      end
    end
    def parse_item url
      doc = fetch_page url
      wenhao = doc.at_css('#rankDescription').text.match(/批准文号】(国药.字[A-Z0-9]+)\[点击查询药品真伪/)[1] rescue nil
      if wenhao.present?
        yaopin = Yaopin.find wenhao
        #pp url
        if yaopin.present?
          price = doc.at_css('#show_mprice').text.gsub(/[¥,]/,'').to_f
          title = doc.at_css('h1').text
          url = url.match(/product-(\d+)/)[1]
          conditions = {url: url, scope: 'jxdyf'}
          e = yaopin.items.where(conditions).first
          hash = {
            price: price,
            title: title
          }
          if e.present?
            e.update_attributes hash
            else
            yaopin.items.create hash.merge(conditions)
            description = doc.at_css('#rankDescription').text.match(/适应症】(.+?)【/)[1] rescue nil
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
