# -*- encoding : utf-8 -*-
#encoding: utf-8
class Yaopin < ActiveRecord::Base
  attr_accessible :benweima, :benweima_beizhu, 
    :changjia_dizhi, :changjia_name, :changjia_guojia, 
    :en, :guige, :jixing, :leibie, :name, :shangpin_name, 
    :wenhao, :yuanwenhao, :pizhunri,:daoqiri,:meta,
    :drug_id,:found_at, :company_id
  resourcify
  belongs_to :drug,:counter_cache=>true
  belongs_to :company,:counter_cache=>true
  has_many :items
  
  # default_scope order("wenhao asc")
  scope :wenhao_order,order("wenhao asc")
  scope :newest,order("id desc")
  scope :inlist,select('id,wenhao')
  acts_as_commentable
  
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
    def test
      n = 100
      limit = 50
      Benchmark.bm(7) do |x|
        #x.report("search:") { n.times {|i| Yaopin.search(:order=>'@random',:per_page=>limit).all } }
        #x.report("id shuffle:")  { n.times {|i| Yaopin.random_by_id_shuffle(limit) } }
        x.report("Jibing random")  { n.times {|i| Jibing.order("rand()").limit(limit).all } }
        x.report("Jibing shuffle")  { n.times {|i| Jibing.random_by_id_shuffle(limit) } }
      end
    end
  end
  class Sfda
    #include Resque::Plugins::Async::Method
    @queue = :sfda
    def self.perform method,*args
      self.new.send method,*args
    end
    def async_get_list table,page
      Resque.enqueue Yaopin::Sfda,:get_list,table,page
    end
    def async_get_item table,id
      Resque.enqueue Yaopin::Sfda,:get_item,table,id
    end
    def initialize
      @url = 'http://app1.sfda.gov.cn/datasearch/face3/'
    end
    def run
      # get_table 25,s
      get_table_lists 25,11097
      # get_table 36
    end
    def process start=1
      get_list 25,start
      i = start + 1
      while i <= @total_page
        async_get_list 25,i
        i+=1
      end
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
        get_list(table,page)
        #delay(:priority=>10).get_list(table,page)
        page+=1
      end
    end
    def get_list(table,page=1)
      doc = get_doc(@url + "search.jsp?tableId=#{table}&curstart=#{page}") 
      #doc = get_doc(@url + "base.jsp?tableId=#{table}&curstart=#{page}") 
      @total_page ||= doc.text.match(/共(\d+)页 共\d+条/)[1].to_i
      #pp doc if Rails.env.test?
      #todo: 检查药品是否存在
      doc.css('p[align=left] a').each do |node|
        wenhao = node.text().match(/国药.字(\w\d+)/)[0] rescue nil
        next if wenhao.nil?
        next if Yaopin.exists?(wenhao: wenhao)
        ms = node.attr("href").match(/tableId=(\d+).+?Id=(\d+)/)
        next if ms.nil?
        #delay.get_item ms[1],ms[2]
        async_get_item ms[1],ms[2]
        # break
      end
    end
    def search keyword
      doc = get_doc(@url + "search.jsp?tableId=25&keyword=#{CGI.escape(keyword)}") 
      doc.css('p[align=left] a').each do |node|
        ms = node.attr("href").match(/tableId=(\d+).+?Id=(\d+)/)
        next if ms.nil?
        #delay.get_item ms[1],ms[2]
        get_item ms[1],ms[2]
        # break
      end
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
      
      (Rails.logger.debug "get_list:wenhao null #{[table,id]}" and return) if data[:wenhao].nil?
      drug = Drug.where(:name=>data[:name]).first_or_create(:en=>data[:en])
      data[:drug_id] = drug.id
      data[:found_at] = Time.now
      r = Yaopin.where(:wenhao=>data[:wenhao]).first
      if r.nil?
        r = Yaopin.create data
        Rails.logger.tagged("Yaopin New"){
          Rails.logger.debug [r.id,r.wenhao,r.pizhunri]
        }
      else
        r.update_attributes data
        Rails.logger.debug ["Exists",r.id,r.wenhao,r.pizhunri]
      end
      if data[:changjia_name].present? && data[:changjia_name] != '----'
        company = Company.where(name: data[:changjia_name]).first_or_create(address: data[:changjia_dizhi])
        r.company = company
        r.save
      end
      r
    end
    #async_method :get_list#,:get_item
    def get_doc url
      Rails.logger.debug "curl:#{url}"
      res = Typhoeus::Request.get(url)
      Nokogiri::HTML(res.body)
    end
  end
end
