# encoding: utf-8

russian_post = DeliveryCategory.create!(:name => "Почта России")

Delivery.create!(name:  "Наложенный платеж", available: true, delivery_category: russian_post)

Delivery.create!(name:  "Предоплата за доставку", available: true, delivery_category: russian_post, full_prepayment_required: true)

moscow = DeliveryCategory.create!(:name => "Доставка по Москве")

Delivery.create!(name:  "Доставка до любой станции метро", available: true, delivery_category: moscow, metro_required: true)

shop = DeliveryCategory.create!(:name => "Самовывоз")

Delivery.create!(name:  "Самовывоз г. Москва", available: true, delivery_category: shop, shop_required: true)
