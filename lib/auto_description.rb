#encoding: utf-8
require 'typhoeus'
require 'nokogiri'
require 'cgi'
class AutoDescription
  def self.query word
    url = "http://wapbaike.baidu.com/search?word=#{CGI.escape word}&submit=进入词条"
    response = Typhoeus.get url,followlocation: true
    if response.success?
      url = response.body.match(/URL=(\/view\/\d+\.htm)\?/)[1] rescue nil
      url.nil? ? nil : parse(url)
    else
      return nil
    end
  end
  def self.parse url
    url = "http://wapbaike.baidu.com" + url
    response = Typhoeus.get url,followlocation: true
    if response.success?
      doc = Nokogiri::HTML(response.body)
      doc.at_css('.card').text().gsub(/\s+/,'').sub(/百科名片/,'') rescue nil
    else
      return nil
    end

  end
end
