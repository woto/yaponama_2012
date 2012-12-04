# encoding: utf-8

FactoryGirl.define do

  sequence(:random_notes_invisible) do |n| 
    "Скрытый комментарий #{n}"
  end


  sequence(:random_notes) do |n| 
    "Видимый комментарий #{n}"
  end

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

        u.notes_invisible{ generate(:random_notes_invisible) }
        u.notes{ generate(:random_notes) }

        after(:build) do |u, evaluator|
          u.names = Random.new.rand(5).times.map{|n| FactoryGirl.build(:name, user:  u)}
          u.phones = Random.new.rand(5).times.map{|n| FactoryGirl.build(:phone, user: u)}
          u.account = FactoryGirl.build(:account, accountable: u)
          u.products = Random.new.rand(5).times.map{|n| FactoryGirl.build(:product, user: u)}
          u.email_addresses = Random.new.rand(3).times.map{|n| FactoryGirl.build(:email_address, user: u)}
          u.time_zone = TimeZone.order("RANDOM()").first
          #u.account.debit = 1
        end

        #after(:create) do |u, evaluator|
        #  u.account.save
        #end
      
      end

    end

  end

end
