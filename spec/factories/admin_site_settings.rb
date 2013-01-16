# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_site_setting, :class => 'Admin::SiteSetting' do
    environment "MyString"
    request_emex false
    emex_income_rate 1.5
    avtorif_income_rate 1.5
    retail_rate 1.5
    robokassa_integration_mode "MyString"
    robokassa_pass_1 "MyString"
    robokassa_pass_2 "MyString"
    robokassa_user "MyString"
    send_request_from_search_page false
    site_address "MyString"
    site_port "MyString"
    redis_address "MyString"
    redis_port "MyString"
    juggernaut_address "MyString"
    juggernaut_port "MyString"
    price_address "MyString"
    price_port "MyString"
  end
end
