# -*- encoding : utf-8 -*-
require 'spec_helper'

describe DrugStores::Jxdyf do
  it "should" do
    d= Drug.create :name=> "布洛芬缓释胶囊"
    ["国药准字H20043430","国药准字H19983137","国药准字H10900089","国药准字H19983137"].each do |str|
      d.yaopins.create :wenhao=>str,:name=>d.name
    end
    DrugStores::Jxdyf.new.search "马来酸恩替卡韦片"
    #DrugStores::Jxdyf.new.parse_item "http://www.jxdyf.com/product-25362.html"
  end
end
