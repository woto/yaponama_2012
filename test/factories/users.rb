# encoding: utf-8

FactoryGirl.define do

  sequence(:random_role) do |n|
    Rails.configuration.user_roles_keys.sample
  end

  sequence(:random_password) do |n|
    rand(100000..999999)
  end

  sequence(:random_notes_invisible) do |n| 
    "Скрытый комментарий #{n}"
  end


  sequence(:random_notes) do |n| 
    "Видимый комментарий #{n}"
  end

  sequence(:random_prepayment_percent) do |n| 
    rand(0..20)
  end

  sequence(:random_discount) do |n| 
    rand(0..30)
  end

  sequence(:random_order_rule) do |n|
    Rails.configuration.user_order_rules.keys.sample
  end

  factory :user do

    factory :minimal_valid_user do

      prepayment_percent{ generate(:random_prepayment_percent) } 
      discount { generate(:random_discount) }
      order_rule{ generate(:random_order_rule) }
      role{ generate(:random_role) }
      password { generate(:random_password) }

      after(:build) do |u, evaluator|
        u.account = FactoryGirl.build(:minimal_valid_account, accountable: u)
      end

      factory :full_filled_user do |u|

        u.notes_invisible{ generate(:random_notes_invisible) }
        u.notes{ generate(:random_notes) }

        after(:build) do |u, evaluator|
          u.names = rand(5).times.map{|n| FactoryGirl.build(:name, user:  u)}
          u.phones = rand(5).times.map{|n| FactoryGirl.build(:phone, user: u)}
          u.products = rand(50..100).times.map{|n| FactoryGirl.build(:product, user: u)}
          u.email_addresses = rand(3).times.map{|n| FactoryGirl.build(:email_address, user: u)}
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
