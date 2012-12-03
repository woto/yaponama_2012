# encoding: utf-8

FactoryGirl.define do

  sequence(:random_prepayment_percent) do |n| 
    Random.new.rand(0..20)
  end

  sequence(:random_discount) do |n| 
    Random.new.rand(0..30)
  end

  sequence(:random_order_rule) do |n|
    Rails.configuration.user_order_rule.keys.sample
  end

  factory :user do

    factory :minimal_valid_user do

      prepayment_percent{ generate(:random_prepayment_percent) } 
      discount { generate(:random_discount) }
      order_rule{ generate(:random_order_rule) }

      factory :full_filled_user do |u|

        after(:build) do |u, evaluator|
          u.names = [FactoryGirl.build(:name, :user => u)]
          u.phones = [FactoryGirl.build(:phone, :user => u)]
          debugger
          puts '1'
          #u.account.debit = 1
        end

        #after(:create) do |u, evaluator|
        #  u.account.save
        #end
      
      end

    end

  end

end
