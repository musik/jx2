# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :option do
    name "MyString"
    data "MyText"
    autoload false
  end
end
