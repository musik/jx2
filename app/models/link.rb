# -*- encoding : utf-8 -*-
class Link < ActiveRecord::Base
  attr_accessible :context, :inhome, :name, :priority, :published, :url,:nofollow,:favicon_type
  validates_presence_of :name,:url

  scope :published,where(:published=>true)
  scope :inhome,where(:inhome=>true)

  def favicon_url
    favicon_type == 1 ? 
      url + "/favicon.ico" : 
        'https://plus.google.com/_/favicon?domain=' + domain
  end
  def domain
    url.match(/http:\/\/([^\/]+)/)[1]
  end

  class << self
    def cached_home
      Rails.cache.fetch "links_inhome" do
        published.inhome.order(:priority).all
      end
    end
    def all_grouped
      rs = {}
      published.order('context desc,priority').all.each do |l|
        rs[l.context] = [] unless rs.has_key? l.context
        rs[l.context] << l
      end
      rs
    end
    def contexts
      group("context").pluck("context")
    end
  end
  class Alivv
    def self.fetch(wid='j*EvJmbCWls=',type=3,code=1)
      url = "http://vvtui.net/htmlcode.aspx?code=#{code}&wid=#{wid}&type=#{type}"
      res = Typhoeus::Request.get(url)
      if res.code == 200
        return CGI.unescape(res.body.encode("UTF-8",'GBK')).gsub(/<a[^>]+>阿里微微<\/a>/,'').
          gsub(/\<\!--alivv code[^>]+--\>/,'')
      end
      ""
    end
  end

end
