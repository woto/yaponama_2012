# encoding: utf-8

FactoryGirl.define do

  sequence :random_mobile_russia_phone_number do |n|
    rand(1000000000..9999999999).to_s
  end

  sequence :random_unknown_phone_number do |n|
    "#{rand(10..999)} - #{rand(10..99)} - #{rand(10..99)}"
  end

  trait :random_mobile_russia_phone do
    phone{ generate(:random_mobile_russia_phone_number) }
    phone_type{ 'mobile_russia' }
  end

  trait :random_unknown_phone do
    phone{ generate(:random_unknown_phone_number) }
    phone_type{ 'unknown' }
  end

  factory :phone do

    factory :phone_with_user do
      association :user, factory: :minimal_valid_user
    end

  end

end
