# -*- encoding : utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link do
    name "MyString"
    url "MyString"
    published false
    priority 1
    context "MyString"
    inhome false
  end
end
