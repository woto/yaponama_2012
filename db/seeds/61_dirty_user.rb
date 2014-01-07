# encoding: utf-8
#
user = User.new
user.assign_attributes( SiteConfig.default_somebody_attributes )
user.role = "user"
user.password = '123123'
user.code_1 = 'seed'
user.phantom = false
user.online = false

account = user.build_account
#account.assign_attributes( {:debit => 0, :credit => 0} )

profile = user.profiles.new
profile.names.new(:name => "Руслан")
profile.phones.new({:value => '+7 (916) 907-27-88', :mobile => true} )
profile.emails.new( {:value => 'oganer@gmail.com'} )

user.save!

20.times do
  catalog_number = TemplateData::CATALOG_NUMBERS.sample
  manufacturer = Brand.where(name: TemplateData::MANUFACTURERS.sample).first_or_create
  short_name = TemplateData::SHORT_NAMES.sample
  product = user.products.create!(catalog_number: catalog_number, brand: manufacturer, short_name: short_name, buy_cost: rand(400..3000), sell_cost: rand(500..4000), quantity_ordered: rand(1..4), code_1: 'fixtures', hide_catalog_number: false)
end
