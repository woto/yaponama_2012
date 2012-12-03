# encoding: utf-8

FactoryGirl.define do

  sequence :random_name do |n|
    "Покупатель #{n}"
  end

  factory :name do

    name{ generate(:random_name) }

    factory :name_with_user do
      association :user, factory: :minimal_valid_user
    end

  end

end
