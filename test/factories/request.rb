# encoding: utf-8

FactoryGirl.define do

  sequence :name do |n|
    "Запрос #{n}"
  end

  factory :request do
    factory :minimal_valid_request do
      name{generate(:random_name)}
      association :user, factory: :minimal_valid_user
    end
  end
end

