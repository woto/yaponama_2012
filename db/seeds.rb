# encoding: utf-8

time_zones = [
  ['Калининградское время	–1', 3, 0], 
  ['Московское время 0', 4, 0], 
  ['Екатеринбургское время +2', 6, 0], 
  ['Омское время +3', 7, 0], 
  ['Красноярское время +4', 8, 0],
  ['Иркутское время +5', 9, 0], 
  ['Якутское время +6', 10, 0], 
  ['Владивостокское время +7', 11, 0], 
  ['Магаданское время	+8', 12, 0]
]

time_zones.each do |time_zone, utc_offset_hours, utc_offset_minutes|
  TimeZone.create(:time_zone => time_zone, :utc_offset_hours => utc_offset_hours, :utc_offset_minutes => utc_offset_minutes)
end

# TODO этого здесь не должно быть
russian_post = DeliveryCategory.create(:name => "Почта России")
Delivery.create!(name:  "Наложенный платеж", available: true, delivery_category: russian_post, full_prepayment_required: false, phone_required: false, name_required: false, postal_address_required: false, delivery_cost_required: false, metro_required: false)
Delivery.create!(name:  "Предоплата за доставку", available: true, delivery_category: russian_post, full_prepayment_required: true, phone_required: false, name_required: false, postal_address_required: false, delivery_cost_required: false, metro_required: false)

moscow = DeliveryCategory.create(:name => "Доставка по Москве")
Delivery.create!(name:  "Доставка до любой станции метро", available: true, delivery_category: moscow, full_prepayment_required: false, phone_required: false, name_required: false, postal_address_required: false, delivery_cost_required: false, metro_required: true)

supplier = Supplier.new(name: "8-я миля")
supplier.build_account
supplier.save!

supplier = Supplier.new(name: "Авториф")
supplier.build_account
supplier.save!

metro = Metro.create!(metro: "Алтуфьево", delivery_cost: 300)
metro = Metro.create!(metro: "Динамо", delivery_cost: 100)
metro = Metro.create!(metro: "Аэропорт", delivery_cost: 100)
metro = Metro.create!(metro: "Сокол", delivery_cost: 200)

user = User.new
user.build_account
user.account.assign_attributes( {:debit => 0, :credit => 0}, :without_protection => true )
user.assign_attributes( Rails.configuration.default_user_attributes, :without_protection => true )
user.role = "admin"
user.password = '1111111111'
phone = user.phones.build
phone.assign_attributes({:phone => '1111111111', :can_receive_sms => 'yes'}, :without_protection => true)
email_address = user.email_addresses.build
email_address.assign_attributes({:email_address => 'demo@example.com'}, :without_protection => true)
user.save!

# /этого здесь не должно быть
