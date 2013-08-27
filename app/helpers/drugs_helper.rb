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
  def item_link_jxdyf r
    link_to("金象大药房","http://www.jxdyf.com/?2b18310b60#{r.url}",:rel=>"nofollow",:target=>"_blank").html_safe
  end
  def item_link_kad r
    link_to("康爱多药店","http://cps.360kad.com/cpstransfer.php?unid=j1008&urlto=http://user.360kad.com/webapi/TrackZaoPai?url=http://www.360kad.com/product/#{r.url}.shtml",:rel=>"nofollow",:target=>"_blank").html_safe
  end
  def item_link_dada360 r
    link_to("九洲药店","http://p.yiqifa.com/c?s=f0022d6b&w=653687&c=5680&i=14462&l=0&e=&t=http://www.dada360.com/#{r.url}.html",:rel=>"nofollow",:target=>"_blank").html_safe
  end
  def item_link_yaofangcn r
    link_to("药房网","http://p.yiqifa.com/c?s=7638421e&w=653687&c=5951&i=23462&l=0&e=&t=http://www.yaofang.cn/goods-#{r.url}.html",:rel=>"nofollow",:target=>"_blank").html_safe
  end
end
