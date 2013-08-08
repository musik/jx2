class Jibing < ActiveRecord::Base
  attr_accessible :name,:items_count
  has_many :ji_items
  def suggest
    url = 'http://ypk.39.net/search/all?k=' + ERB::Util.url_encode(ActiveSupport::JSON::Encoding.escape(name).gsub(/\"/,'').gsub("\\",'%'))
    pp url
    response = Typhoeus::Request.get url
    pp response.body
    doc = Nokogiri::HTML(response.body)
    doc.css('#con_main_ul li').each do |li|
      pp li
      pp li.at_css('h4 a').text()
    end
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
