# encoding: utf-8

FactoryGirl.define do

  sequence :random_debit do |n|
    Random.new.rand(0..100)
  end

  factory :account do

    factory :minimal_valid_account do

      debit 0
      credit 0

      factory :random_account do
        debit{ generate(:random_debit) }
      end

    end

  end

end
