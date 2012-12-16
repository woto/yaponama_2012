# encoding: utf-8

FactoryGirl.define do

  sequence :random_email_address do |n|
    "email_address_#{n}@example.ru"
  end

  factory :email_address do
    email_address{ generate(:random_email_address) }

    after(:build) do |ea, evaluator|
      ea.added_by = generate(:random_added_by)
    end

    factory :email_address_with_user do
      association :user, factory: :minimal_valid_user
    end

  end

end

