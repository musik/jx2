#encoding: utf-8
require 'spec_helper'

describe Province do
  it "takes time" do
    #pp Province.detect_province_and_city "合肥市长江西路669号高新技术开发区"
    #pp Province.detect_province_and_city "南运河,南曲靖"
    a =0 
    b =0
    c =0
    t1 = Time.now
    Yaopin.group(:changjia_name).select('changjia_name,changjia_dizhi').each do |r|
      str = [r.changjia_name , r.changjia_dizhi].join(',')
      hash = Province.detect_province_and_city(str)
      p = hash[:province]
      ct = hash[:city]
      if p.present? && ct.present?
        a+=1
      elsif p.present?
        b+=1
      else
        c+=1
      end
    end
    pp a,b,c
    t2 = Time.now
    pp t1,t2
  end
end
