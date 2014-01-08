#encoding: utf-8
class Shop < ActiveRecord::Base
  attr_accessible :address, :affurl, :cert, :company_name, :domain, :expires_in, :linked, :name, :owner, :reg_in, :service, :website,:nicename,
    :pr,:br,:alexa, :priority
  validates :name,presence: true
  validates :website,presence: true
  def self.import(data)
    if !exists?(cert: data[:cert])
      create(data)
    end
  end
  def url
    affurl.present? ?
      affurl :
        (linked? ? website : "/yaodian/#{id}/redirect")
  end
  def nofollow?
    affurl.present? or !linked?
  end
  def rel
    nofollow? ? {rel: 'nofollow'} : {}
  end
  def as_json options={}
    self[:domain] = website.sub('http://','').sub(/^www./,'')
    self[:br] ||= -1
    self[:pr] ||= -1
    self[:alexa] ||= 999999999
    #self[:nicename] = name.truncate(10)
    options = {only: %w(name affurl website domain cert reg_in expires_in id pr br alexa)}.merge(options)
    super
  end
  def self.update_all_ranks
    where(alexa: nil).find_each do |r|
      ranks = PageRankr.ranks(r.website.sub('http://',''),
        :google,:baidu,:alexa_global) rescue nil
      next if ranks.nil?
      r.update_attributes(pr: ranks[:google],
                          br: ranks[:baidu],
                          alexa: ranks[:alexa_global])
    end
  end
  class Sfda < Yaopin::Sfda
    def initialize table
      @table = table
      @url = 'http://app1.sfda.gov.cn/datasearch/face3/'
    end
    def async_get_item table,id
      get_item id
    end
    def get_list id
      super @table,id
    end
    def process start=1
      get_list start
      i = start + 1
      while i <= @total_page
        get_list i
        i+=1
      end
    end
    def get_item id
      doc = get_doc (@url + "content.jsp?tableId=#{@table}&tableName=TABLE#{@table}&Id=#{id}")
      ignores = %w(邮编 IP地址)
      data = {}
      keys = {
        "证书编号"=>:cert,
         "服务范围"=>:service,
         "单位名称"=>:company_name,
         "发证日期"=>:reg_in,
         "有效截至日期"=>:expires_in,
         "法定代表人"=>:owner,
         "单位地址"=>:address,
         "网站名称"=>:name,
         "域名"=>:domain,
      }
      doc.css('table[align=center] tr').each do |tr|
        td2 = tr.css('td')[1]
        next if td2.nil?
        key = tr.css('td')[0].text
        next if ignores.include? key
        val = td2.text.strip
        next if val.blank?
          
        if keys.has_key? key
          data[keys[key]] = val
        end
      end
      data[:domain] = 'www.yaofangwang.com' if data[:domain].nil? && data[:cert] == '国A20110001'
      if data[:domain].present?
        data[:domain].gsub!('http://','')
        website = data[:domain].match(/[\w\d\-\.]+/i)[0]
        website = "www."+ website if website[0,4] != 'www.'
        data[:website] = "http://" + website
      end
      data[:name].gsub!(/\s/,'')
      Shop.import(data)
    end
  end
end
