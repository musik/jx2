#encoding: utf-8
class Company < ActiveRecord::Base
  belongs_to :city
  belongs_to :province
  attr_accessible :address, :name, :short, :yaopins_count,:city_id,:province_id
  def detect_data
    str = [name , address].join(',')
    hash = Province.detect_province_and_city(str)
    self.city = hash[:city]
    self.province = hash[:province]
    self.short = name.gsub(/\(有限责任公司\)|\(有限公司\)|有限责任公司|股份有限公司|有限公司/,'')
    #self.yaopins_count = Yaopin.where()
  end
  def self.autogen
    Yaopin.group(:changjia_name).select('changjia_name,changjia_dizhi').each do |yp|
      import_from(yp.changjia_name,yp.changjia_dizhi)
    end
  end
  def self.import_from name,address
    return if name == '----'
    c = new(name: name,address: address)
    c.detect_data
    c.yaopins_count = Yaopin.where(changjia_name: name).count
    c.save
    Yaopin.where(changjia_name: name).update_all(company_id: c.id)
    c
  end
end

