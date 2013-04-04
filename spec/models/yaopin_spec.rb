# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Yaopin do
  it "should sdfa" do
    #Yaopin::Sfda.new.run
    #Yaopin::Sfda.new.get_list(25,2443)
    Yaopin::Sfda.new.get_item(25,78298)
    # Drug.import_yaopins  
    #Yaopin::Sfda.new.get_table_lists 25,10,1
    #pp Typhoeus::Request.get 'https://api.weibo.com/2/search/statuses.json?source=2280610509&q=ruby'
    #key = 801242191
    #pp Typhoeus::Request.get 'http://open.t.qq.com/api/search/t?format=json&keyword=ruby&openkey=' + key.to_s
  end
end
