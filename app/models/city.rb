# coding: utf-8
class City < ActiveRecord::Base
  if Rails.version < '4.0'
    attr_accessible :name, :province_id, :level, :zip_code, :pinyin, :pinyin_abbr
  end
  scope :active,->{where(active: true)}

  belongs_to :province
  has_many :districts, dependent: :destroy

  def short_name
    @short_name ||= name.gsub(/市|自治州|地区|特别行政区/,'')
  end

  def brothers
    @brothers ||= City.where("province_id = #{province_id}")
  end
  def self.all_with_az
    hash = {}
    active.all.each{|c|
      k = c.pinyin[0,1] 
      hash.key?(k) ? hash[k].push(c) : hash[k] = [c]
    }
    Hash[hash.sort]
  end
  def self.fix_with_58
    City.find_each do |c|
      c.fullname = c.name if c.fullname.nil?
      c.name = c.short_name.gsub(/藏族|苗族|土家族|傣族|朝鲜族|布依族|侗族|回族|蒙古族|哈尼族|景颇族|彝族|羌族|傈僳族|壮族|白族/,'')
      c.save
    end
    cities = F58.new.fetch_cities
    cities.each do |k,v|
      if c  = City.find_by_name(v)
        c.update_attribute :active,true
      end
    end
  end
end
