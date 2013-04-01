# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Drug do
  it "should" do
    # Yaopin::Sfda.new.get_list(25,803)
    # y1 = Yaopin.first
    # y2 = Yaopin.last
    # y2.update_attribute :name,y1.name
    # Drug.import_yps
#    pp TOPDRUGS
    [11,31,51,61,101].each do |i|
      rs = mz_load_topdrugs(i)
      pp [i,rs.keys.size,rs.values.reduce(:+)]
    end
  end
end
