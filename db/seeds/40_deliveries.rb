# encoding: utf-8

russian_post = DeliveryCategory.create(:name => "Почта России")

Delivery.create!(name:  "Наложенный платеж", available: true, delivery_category: russian_post, full_prepayment_required: false, phone_required: false, name_required: false, postal_address_required: false, delivery_cost_required: false, metro_required: false)

Delivery.create!(name:  "Предоплата за доставку", available: true, delivery_category: russian_post, full_prepayment_required: true, phone_required: false, name_required: false, postal_address_required: false, delivery_cost_required: false, metro_required: false)

moscow = DeliveryCategory.create(:name => "Доставка по Москве")

Delivery.create!(name:  "Доставка до любой станции метро", available: true, delivery_category: moscow, full_prepayment_required: false, phone_required: false, name_required: false, postal_address_required: false, delivery_cost_required: false, metro_required: true)
