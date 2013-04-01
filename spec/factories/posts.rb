# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    title "MyString"
    content "MyText"
    publish false
    laiyuan "MyString"
    laiyuan_url ""
    author "MyString"
  end
end
