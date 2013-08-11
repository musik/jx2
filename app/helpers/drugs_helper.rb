# -*- encoding : utf-8 -*-
#encoding: utf-8
module DrugsHelper
  def shuoming_url drug
    "/#{CGI.escape(drug.name)}/%E8%AF%B4%E6%98%8E%E4%B9%A6"
  end
  def yao_url drug
    "/#{CGI.escape(drug.name)}"
  end
  def yao_url_str str
    "/#{CGI.escape(str)}"
  end
  def autolink_to_jibing(text)
    @jibing_names ||= begin
                        Regexp.new(Jibing.pluck(:name).join("|"))
                      end
    text.sub(@jibing_names,'<a href="/jibing?name=\0">\0</a>')
  end
end
