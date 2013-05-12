# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :delivery_zone_coord do
    lat 1.5
    lng 1.5
    delivery_zone nil
  end
end
