# encoding: utf-8

user = User.new
user.build_account
user.account.assign_attributes( {:debit => 0, :credit => 0} )
user.assign_attributes( SiteConfig.default_user_attributes )
user.role = "admin"
user.names.new(:name => "Администратор", :creation_reason => "manager")
user.password = '1111111111'
phone = user.phones.build
phone.assign_attributes({:phone => '1111111111', :phone_type => 'mobile_russia', :creation_reason => 'manager'} )
email_address = user.email_addresses.build
email_address.assign_attributes( {:email_address => 'demo@example.com'} )
user.save!
20.times do
  user.products.create(catalog_number: TemplateData::CATALOG_NUMBERS.sample, manufacturer: TemplateData::MANUFACTURERS.sample, short_name: TemplateData::SHORT_NAMES.sample, buy_cost: rand(400..3000), sell_cost: rand(500..4000), quantity_ordered: rand(1..4))
end

5.times do
  user = User.new
  user.build_account
  user.assign_attributes( SiteConfig.default_user_attributes )
  user.role = "user"
  user.names.new(:name => "Покупатель", :creation_reason => "manager")
  user.password = '123123'
  phone = user.phones.build
  phone.assign_attributes({:phone => '123123', :phone_type => 'unknown', :creation_reason => 'manager'} )
  user.save!
  20.times do 
    user.products.create(catalog_number: TemplateData::CATALOG_NUMBERS.sample, manufacturer: TemplateData::MANUFACTURERS.sample, short_name: TemplateData::SHORT_NAMES.sample, buy_cost: rand(400..3000), sell_cost: rand(500..4000), quantity_ordered: rand(1..4))
  end
end
