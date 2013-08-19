# -*- encoding : utf-8 -*-
require 'spec_helper'

describe DrugStores::Kad do
  it "should" do
    name = "布洛芬缓释胶囊"
    d= Drug.create :name=> name
    ["国药准字H44021099","国药准字H10950286","国药准字H10900089","国药准字H19991011"].each do |str|
      d.yaopins.create :wenhao=>str,:name=>d.name
    end
    DrugStores::Kad.new.search name
    #DrugStores::Kad.new.parse_item "http://www.jxdyf.com/product-25362.html"
  end
end
