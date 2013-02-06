# encoding: utf-8

FactoryGirl.define do
  sequence :random_utc_offset_hours do |n|
    rand(-5..5)
  end

  sequence :random_utc_offset_minutes do |n|
    [0, 30].sample
  end

  sequence :random_time_zone do |n|
    "Часовой пояс #{n}"
  end

  factory :time_zone do
    factory :minimal_valid_time_zone do
      time_zone { generate(:random_time_zone) }
      utc_offset_hours { generate(:random_utc_offset_hours) }
      utc_offset_minutes { generate(:random_utc_offset_minutes) }
    end
  end
end
