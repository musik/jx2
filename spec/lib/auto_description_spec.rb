#encoding: utf-8
require 'auto_description'
describe AutoDescription do
  it "query 树脂工艺品" do
    #AutoDescription.query("树脂工艺品").should be_a(String)
    #AutoDescription.query("rails").should be_a(String)
    #AutoDescription.query("为人民服务").should be_a(String)
  end
  it "query 创意香包" do
    #AutoDescription.query("感冒咳嗽").should be_nil
    #AutoDescription.query("创意香包").should be_nil
  end
end
