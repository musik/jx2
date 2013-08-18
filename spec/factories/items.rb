# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    title "MyString"
    url "MyString"
    price "9.99"
    yaopin nil
    scope "MyString"
  end
end
