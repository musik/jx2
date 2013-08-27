# -*- encoding : utf-8 -*-
require 'spec_helper'

describe DrugStores::Dada360 do
  it "should" do
    name = "布洛芬缓释胶囊"
    d= Drug.create :name=> name
    ["国药准字H19993592","国药准字H10950286","国药准字H10900089","国药准字H19991011"].each do |str|
      d.yaopins.create :wenhao=>str,:name=>d.name
    end
    #DrugStores::Dada360.new.search name
    #DrugStores::Dada360.new.parse_item "http://www.dada360.com/47072.html"
  end
end
