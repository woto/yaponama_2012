# encoding: utf-8

user = User.new
user.assign_attributes( SiteConfig.default_user_attributes )
user.role = "admin"
user.password = '1111111111'

account = user.build_account
account.assign_attributes( {:debit => 0, :credit => 0} )

profile = user.profiles.new
profile.names.new(:name => "Администратор", :creation_reason => "profile")
profile.phones.new({:phone => '1111111111', :phone_type => 'mobile_russia', :creation_reason => 'profile'} )
profile.email_addresses.new( {:email_address => 'admin@example.com'} )

user.save!

20.times do
  user.products.create(catalog_number: TemplateData::CATALOG_NUMBERS.sample, manufacturer: TemplateData::MANUFACTURERS.sample, short_name: TemplateData::SHORT_NAMES.sample, buy_cost: rand(400..3000), sell_cost: rand(500..4000), quantity_ordered: rand(1..4))
end
