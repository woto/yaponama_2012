# encoding: utf-8
#
user = User.new
user.assign_attributes( SiteConfig.default_somebody_attributes )
user.role = "admin"
user.password = '1111111111'
user.code_1 = 'seed'
user.phantom = false
user.online = false

account = user.build_account
#account.assign_attributes( {:debit => 0, :credit => 0} )

profile = user.profiles.new
profile.names.new(:name => "Администратор")
profile.phones.new({:value => '+7 (111) 111-11-11', :mobile => true, :confirmed => true} )
profile.emails.new( {:value => 'admin@example.com', :confirmed => true} )

user.save!

20.times do
  catalog_number = TemplateData::CATALOG_NUMBERS.sample
  manufacturer_name = TemplateData::MANUFACTURERS.sample.upcase
  manufacturer = Brand.where("upper(name) = ?", manufacturer_name).first || Brand.new(name: manufacturer_name)
  short_name = TemplateData::SHORT_NAMES.sample
  min_days = rand(1..10)
  max_days = min_days + rand(5)
  product = user.products.create!(catalog_number: catalog_number, brand: manufacturer, short_name: short_name, buy_cost: rand(400..3000), sell_cost: rand(500..4000), quantity_ordered: rand(1..4), code_1: 'fixtures', hide_catalog_number: false, min_days: min_days, max_days: max_days)
end

product = user.products.create!(catalog_number: 'TIME', brand: Brand.first, buy_cost: rand(400..3000), sell_cost: rand(500..4000), quantity_ordered: rand(1..4), code_1: 'fixtures', hide_catalog_number: false, min_days: 1, max_days: 2)
