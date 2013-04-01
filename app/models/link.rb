# -*- encoding : utf-8 -*-
class Link < ActiveRecord::Base
  attr_accessible :context, :inhome, :name, :priority, :published, :url
  validates_presence_of :name,:url

  scope :published,where(:published=>true)
  scope :inhome,where(:inhome=>true)


  class << self
    def cached_home
      Rails.cache.fetch "links_inhome" do
        published.inhome.order(:priority).all
      end
    end
    def all_grouped
      rs = {}
      published.order(:priority).all.each do |l|
        rs[l.context] = [] unless rs.has_key? l.context
        rs[l.context] << l
      end
      rs
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
