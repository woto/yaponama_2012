# encoding: utf-8

FactoryGirl.define do

  sequence :random_debit do |n|
    Random.new.rand(0..100)
  end

  factory :account do
    debit{ generate(:random_debit) }

    #name{ generate(:random_name) }

    #factory :name_with_user do
    #  association :user, factory: :minimal_valid_user
    #end

  end

end
