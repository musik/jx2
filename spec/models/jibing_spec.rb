#encoding: utf-8
require 'spec_helper'

describe Jibing do
  it "should fetch jibins" do
    #Jibin::Aizhan.list
    #Jibing.create(:name=>"宝宝拉肚子")
    Jibing.last.suggest 
  end  
end
