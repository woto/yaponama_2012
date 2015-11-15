# encoding: utf-8
#
user = User.new
user.role = "admin"
user.password = '1111111111'

user.name = "Администратор"
user.phone = '+7 (111) 111-11-11'
user.email = 'admin@example.com'

user.save!

product = user.products.create!(creator: user, catalog_number: 'TIME', brand: BrandMate.find_or_create_company('TIME'), buy_cost: rand(400..3000), sell_cost: rand(500..4000), quantity_ordered: rand(1..4), hide_catalog_number: false, min_days: 1, max_days: 2)
