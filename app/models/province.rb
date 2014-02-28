#encoding: utf-8
class Province < ActiveRecord::Base
  if Rails.version < '4.0'
    attr_accessible :name, :pinyin, :pinyin_abbr
  end

  has_many :cities, dependent: :destroy
  has_many :districts, through: :cities

  def self.find_from_string str
    str = str.join(',') if str.is_a?(Array)
    patt = /上海|云南|内蒙古|北京|台湾|吉林|四川|天津|宁夏|安徽|山东|山西|广东|广西|新疆|江苏|江西|河北|河南|浙江|海南|湖北|湖南|澳门|甘肃|福建|西藏|贵州|辽宁|重庆|陕西|青海|香港|黑龙江/
    if match = str.match(patt)
      where("name like '%#{match.to_s}%'").first
    end
  end
  def self.detect_city str,p = nil
    if p.present?
      hash = Hash[p.cities.select('id,name').all.collect{|r| [r.id,r.name]}]
    else
      hash = Hash[City.select('id,name').all.collect{|r| [r.id,r.name]}]
    end
    r = find_id_from_str(hash,str)
    if r.nil?
      hash = Hash[hash.collect{|r| r[1].sub!(/市|地区$/,'');r}]
      r = find_id_from_str(hash,str)
    end
    r.present? ? City.find(r) : nil
  end
  def self.find_id_from_str hash,str
    hash = Hash[hash.sort{|a,b| b[1].length <=> a[1].length}]
    patt = Regexp.new(hash.values.join('|'))
    if match = str.match(patt)
      hash.key(match.to_s)
    end
  end
  def self.detect_province_and_city str
    p = find_from_string(str)
    c = detect_city(str,p)
    if c.present? && p.nil?
      p = c.province
    end
    {province: p, city: c}
  end
end
