# -*- encoding : utf-8 -*-
#encoding: utf-8
class Category < ActiveRecord::Base
  attr_accessible :name, :parent_id,:drugs_count
  
  acts_as_nested_set
  
  has_many :drugs
  
  resourcify
  
  def to_param
    # (name.present? and name.match(/\//).nil?) ? name : id
    [id,name.gsub(/\//,'-')].join('-')
  end
  
  def self.tree
    rs = {0=>[]}
    all.each do |r|
      if r.root?
        rs[0] << r
      else
        rs[r.parent_id] ||= []
        rs[r.parent_id] << r
      end
    end
    rs
  end
  class << self
    def find *args
      if args.size == 1 and args[0].is_a? String
        if match = args[0].match(/^(\d*)-/) and match.present?
          return super(match[1])
        else
          return find_by_name(args[0])  
        end
      end
      super
    end
  end
  
  class Robot
    def initialize
      
    end
    def run
      res = Typhoeus::Request.get('http://www.chinapharm.com.cn/html/database/drugmanual/')
      doc = Nokogiri::HTML(res.body.encode('utf-8','GBK'))
      doc.css('table[width="85%"] td[width="50%"] > a').each do |a|
        c = parse_link a
        # delay.get_page a.attr("href"),c
        puts c.name
        delay.get_page(a.attr("href"),c) if c.leaf?
        break if Rails.env.test?
      end
    end
    def parse_link a,p=nil
      if p.nil?
        c = Category.where(:name=>a.text.strip).first_or_create
      else
        c = p.children.where(:name=>a.text.strip).first_or_create
      end
      # pp c if Rails.env.test?
      ul = next_ul a
      unless ul.nil?
        ul.css('> a').each do |a|
          parse_link a,c
        end
      end
      Category.find c.id
    end  
    def get_page url,root
      url = "http://www.chinapharm.com.cn#{url}/"
      res = Typhoeus::Request.get(url)
      pp url if Rails.env.test?
      doc = Nokogiri::HTML(res.body.encode('utf-8','GBK'))
      doc.css('table[width="90%"] td ul').each do |ul|
        next unless ul.css('> ul').empty?
        if root.leaf?
          c = root
        else
          a = find_node ul,'a'
          next if a.nil?
          c = root.descendants.find_by_name(a.text.strip)
        end
        
        pp c if Rails.env.test?
        ul.css('a').each do |a|
          d = Drug.where(:name=>a.text.strip).first_or_create
          d.category = c
          d.save
          pp d if Rails.env.test?
          delay(:priority=>10).get_item a.attr("href"),d
        end
      end
    end
    def get_itemx url,drug=nil
      res = Typhoeus::Request.get("http://www.chinapharm.com.cn#{url}")
      
      # str = coder.decode(res.body)
      str = res.body.force_encoding("UTF-8")
    end
    def get_item url,drug=nil
      res = Typhoeus::Request.get("http://www.chinapharm.com.cn#{url}")
      begin
        #.encode("utf-8",'GBK')
        coder = HTMLEntities.new(:html4)
        doc = Nokogiri::HTML(coder.decode(res.body.encode("utf-8",'GBK')))
      rescue
        Rails.logger.info "encoding error http://www.chinapharm.com.cn#{url}"
        return
      end
      data = {}
      maintable = doc.css('td[width="606"] table')[2]
      maintable.css('tr').each do |tr|
        val = tr.css('td')[1].text.strip.gsub(/\r\n/,'').gsub(/^ +$/,'')
        next if val.blank?
        key = tr.css('td')[0].text.strip
        key = :name if key == "通用名" 
        data[key] = val
      end
      drug = Drug.import_shuoming data
      pp drug if Rails.env.test?
      
      drug.chengfens << parse_chengfens(doc)
    end
    def parse_chengfens doc
      hash = []
      data = {}
      if node = doc.css('td[width="606"] table')[3] and node.present?
        if node.css('tr')[0].text == "主要成分"
          node.css('tr').each do |tr|
            next if tr.css('td')[1].nil?
            val = tr.css('td')[1].text.strip.gsub(/\r\n/,'')
            next if val.blank?
            key = tr.css('td')[0].text.strip
            if key == "通用名"
              hash << Chengfen.import(data) if data.has_key? :name
              data = {:name => val}
            elsif data.has_key? :name
              data[key] = val
            end
          end
          hash << Chengfen.import(data) if data.has_key? :name
        end
      end
      hash
    end
    def next_ul node
      ul = node.next
      return nil if ul.nil?
      while ul.name == 'br'
        ul = ul.next
        return nil if ul.nil?
      end
      ul.name == 'ul' ? ul : nil
    end
    def find_node node,name,meth='previous',ignore='br'
      begin
        node = node.send meth
        while node.name == ignore
          node = node.send meth 
        end
        node.name == name ? node : nil
      rescue
        nil
      end
    end
  end
end
