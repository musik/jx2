# -*- encoding : utf-8 -*-
#encoding: utf-8
class Yaopin < ActiveRecord::Base
  attr_accessible :benweima, :benweima_beizhu, 
    :changjia_dizhi, :changjia_name, :changjia_guojia, 
    :en, :guige, :jixing, :leibie, :name, :shangpin_name, 
    :wenhao, :yuanwenhao, :pizhunri,:daoqiri,:meta,
    :drug_id
  resourcify
  belongs_to :drug,:counter_cache=>true
  
  # default_scope order("wenhao asc")
  scope :wenhao_order,order("wenhao asc")
  scope :newest,order("pizhunri desc")
  scope :inlist,select('id,wenhao')
  
  define_index do
    indexes :name,:shangpin_name,:wenhao,:changjia_name,:yuanwenhao,:en
    has :jixing,:leibie
    has :created_at
    has :daoqiri,:pizhunri
  end
  sphinx_scope :fullscan do {:match_mode=>:fullscan} end
  sphinx_scope :slimit do |num| {:per_page=>num} end
  sphinx_scope :by_changjia do |name|
    {:conditions=>{:changjia_name=>name}}
  end
  #sphinx_scope : {:match_mode=>:fullscan}
  def to_param
    wenhao.present? ? wenhao : id
  end
  def wenhao_and_name
    "#{wenhao} / #{name}"
  end
  class << self
    def find *args
      return find_by_wenhao(args[0]) if args.size == 1 and args[0].is_a? String
      super
    end
    def all_leibie
      Rails.cache.fetch "all-leibie" do
        Yaopin.group(:leibie).pluck(:leibie)
      end
    end
  end
  class Sfda
    def initialize
      @url = 'http://app1.sfda.gov.cn/datasearch/face3/'
    end
    def run
      # get_table 25,s
      get_table_lists 25,12563,3176
      # get_table 36
    end
    def get_table table,page=1
      begin
        rs = get_list(table,page)
        page += 1
        puts page
      end while rs
    end
    def get_table_lists table,pages,page=1
      while page <= pages
        delay(:priority=>10).get_list(table,page)
        page+=1
      end
    end
    def get_list(table,page=1)
      doc = get_doc(@url + "search.jsp?tableId=#{table}&curstart=#{page}") 
      #doc = get_doc(@url + "base.jsp?tableId=#{table}&curstart=#{page}") 
      total_page = doc.text.match(/共(\d+)页 共\d+条/)[1].to_i
      total_page = 1 if Rails.env.test? and total_page > 1
      # pp doc if Rails.env.test?
      doc.css('p[align=left] a').each do |node|
        ms = node.attr("href").match(/tableId=(\d+).+?Id=(\d+)/)
        next if ms.nil?
        delay.get_item ms[1],ms[2]
        # break
      end
      return total_page > page
    end
    def get_item table,id
      doc = get_doc (@url + "content.jsp?tableId=#{table}&tableName=TABLE#{table}&Id=#{id}")
      data = {:meta=>{}}
      ignores = %w(相关数据库查询 注)
      ignores << ""
      if table.to_i == 25
        data[:changjia_guojia] = "中国"
        keys = {
          "批准文号"=>:wenhao,
           "原批准文号"=>:yuanwenhao,
           "药品本位码"=>:benweima,
           "药品本位码备注"=>:benweima_beizhu,
           "产品名称"=>:name,
           "英文名称"=>:en,
           "商品名"=>:shangpin_name,
           "生产单位"=>:changjia_name,
           "生产地址"=>:changjia_dizhi,
           "规格"=>:guige,
           "剂型"=>:jixing,
           "产品类别"=>:leibie,
           "批准日期"=>:pizhunri
        }
      else
        keys = {
          "注册证号"=>:wenhao,
           "原注册证号"=>:yuanwenhao,
           "药品本位码"=>:benweima,
           "药品本位码备注"=>:benweima_beizhu,
           "产品名称（中文）"=>:name,
           "产品名称（英文）"=>:en,
           "商品名（中文）"=>:shangpin_name,
           "生产厂商（英文）"=>:changjia_name,
           "厂商国家（中文）"=>:changjia_guojia,
           "厂商地址（英文）"=>:changjia_dizhi,
           "规格（中文）"=>:guige,
           "剂型（中文）"=>:jixing,
           "产品类别"=>:leibie,
           "发证日期"=>:pizhunri,
           "有效期截止日"=>:daoqiri,
        }
      end
      doc.css('table[align=center] tr').each do |tr|
        td2 = tr.css('td')[1]
        next if td2.nil?
        key = tr.css('td')[0].text
        next if ignores.include? key
        val = td2.text.strip
        next if val.blank?
          
        if keys.has_key? key
          data[keys[key]] = val
        else
          data[:meta][key] = val
        end
      end
      
      return if data[:wenhao].nil?
      drug = Drug.where(:name=>data[:name]).first_or_create(:en=>data[:en])
      data[:drug_id] = drug.id
      r = Yaopin.where(:wenhao=>data[:wenhao]).first_or_create data
      pp r if Rails.env.test?
    end
    def get_doc url
      res = Typhoeus::Request.get(url)
      Nokogiri::HTML(res.body)
    end
  end
end
