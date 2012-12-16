# encoding: utf-8

FactoryGirl.define do

  sequence :random_phone do |n|
    n + 1000000000
  end

  sequence :random_added_by do |n|
    ['Менеджером', 'Покупателем'].sample
  end

  sequence :random_can_receive_sms do |n|
    ['Да', 'Нет', 'Неизвестно'].sample
  end

  factory :phone do

    phone{ generate(:random_phone) }

    can_receive_sms{ generate(:random_can_receive_sms)}

    after(:build) do |p, evaluator|
      p.added_by = generate(:random_added_by)
    end

    factory :phone_with_user do
      association :user, factory: :minimal_valid_user
    end

  end

end
