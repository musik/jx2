#encoding: utf-8
module DrugStores
  class Yaofangcn < Base
    @queue = 'stores_search'
    def self.perform name
      self.new.search name
    end
    def async_search name
      Resque.enqueue(Yaofangcn,name)
    end
    def search name
      url = "http://www.yaofang.cn/n/public/search/?s_words=#{CGI.escape name}"
      doc = fetch_page url 
      hrefs = []
      doc.css("#list dd.title a").each do |a|
        hrefs << "http://www.yaofang.cn" + a.attr("href")
      end
      if hrefs.present?
        hrefs.uniq.each do |url|
          parse_item url
        end
      end
    end
    def parse_item url
      pp url if Rails.env.test?
      doc = fetch_page url
      wenhao = doc.at_css('.pro_baseinfo').text.match(/国药.字[A-Z0-9]+/).to_s rescue nil
      pp wenhao if Rails.env.test?
      if wenhao.present?
        price = doc.at_css('.pro_baseinfo em.orange span img').attr('src').match(/\/([0-9\.]+)/)[1].to_f
        title = doc.at_css('h1 span').previous.text.strip
        url = url.match(/(\d+)\.html/)[1]
        conditions = {url: url, scope: 'yaofangcn'}
        hash = {price: price,title: title}
        description = doc.at_css('.pro_baseinfo li.jyms span').text.gsub(/[\r\n]/,'') rescue nil
        pp conditions,hash,description if Rails.env.test?
        yaopin = Yaopin.find wenhao
        if yaopin.present?
          e = yaopin.items.where(conditions).first
          if e.present?
            e.update_attributes hash
            else
            yaopin.items.create hash.merge(conditions)
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
