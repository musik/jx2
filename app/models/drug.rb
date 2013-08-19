# -*- encoding : utf-8 -*-
class Drug < ActiveRecord::Base
  attr_accessible :en, :name,:abbr,:abbr2,:yaopins_count,:category_id,
                  :shuoming, :has_shuoming, :meta,:items_count
  has_many :yaopins
  has_many :items,:through=>:yaopins,:uniq=>true#,:include=>:yaopin
  belongs_to :category,:counter_cache => true
  has_and_belongs_to_many :chengfens
  
  scope :inlist,select([:id,:en, :name,:yaopins_count,:category_id,:has_shuoming])
  scope :yaopin_order,order("yaopins_count desc")
  has_many :ji_items,:include=>:jibing
  has_many :jibings,:through=>:ji_items,:uniq=>true
  
  resourcify
  
  def to_param
    (name.present? and name.match(/\//).nil?) ? CGI.escape(name) : id
  end
  def shuominghash
    YAML.load(shuoming) rescue [] 
  end
  def hashdata str
    YAML.load(send(str)) rescue []
  end
  def jifen
    num = 0
    num += 5 if has_shuoming?
    num += 5 if yaopins_count.present?
    num 
  end
  
  before_save :gen_abbrs
  
  def gen_abbrs
    str = name.to_url
    self[:abbr] = str[0,1]
    self[:abbr2] = str[0,2]
    self[:has_shuoming] = self[:shuoming].present?
    self
  end
  def update_items_count
    update_attribute :items_count,items.count
  end

  class << self
    def find *args
      return find_by_name(args[0]) if args.size == 1 and args[0].is_a? String
      super
    end
    def shouzis min=0
      r = group(:shouzi)
      r = r.having('count_all > ?',min)
      r = r.count
      r.sort{|a,b| b[1] <=> a[1]}
    end
    #全体更新last word
    def last_words
      words = {}
      find_each do |r|
        str = r.name[-1]
        words.has_key?(str) ? words[str]+=1 : words[str]=1
      end
      words
    end
    def update_all_items store_name='jxdyf'
      find_each do |r|
        #pp "UPDATE_ITEMS:#{r.name}" if Rails.env.development?
        next if r.name.length < 2
        eval "DrugStores::#{store_name.classify}.new.async_search(\"#{r.name}\")"
      end
    end
    def update_all_items_count 
      find_each do |r|
        r.update_attribute :items_count,r.items.count
      end
    end
    # 药品对应的产品剂型、类别
    def test_leixing
      require 'pp'
      col = :jixing
      where("yaopins_count > 0").select(:id).find_each(:batch_size=>100) do |d|
        num = Yaopin.where(:drug_id=>d.id).group(col).pluck(col).count
        next if num == 1
        pp find(d.id)
        pp Yaopin.where(:drug_id=>d.id).group(col).pluck(col)
      end
    end
    def test_score
      p count
      p where(:yaopins_count=>nil,:has_shuoming=>false).count
      p where(:has_shuoming=>true).count
      p where(:yaopins_count=>nil).count
      # find_each(:batch_size=>100) do |d|
        # p d.jifen
      # end
    end
    def import_yaopins
      while
        y = Yaopin.where(:drug_id=>nil).first
        break if y.nil?
        import_yp y
      end
    end
    def import_yps
      Yaopin.where(:drug_id=>nil).group(:name).pluck(:id).each do |id|
        import_yp(Yaopin.find(id))
      end
    end
    def import_yp yp
      d = where(:name=>yp.name).first_or_create(:en=>yp.en)
      raise if d.id.nil?
      Yaopin.where(:drug_id=>nil,:name=>d.name).each do |y|
        y.drug = d
        y.save
      end 
    end
    def import_shuoming data
      name = data.delete :name
      return if name.nil?
      e = where(:name=>name).first_or_create :shuoming=>data
      e.update_attribute :shuoming,data if e.shuoming.nil?
      e
    end
  end
end
