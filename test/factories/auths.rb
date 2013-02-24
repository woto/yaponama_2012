# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :auth do
    provider "MyString"
    uid "MyString"
    user nil
    data "MyText"
  end
end
