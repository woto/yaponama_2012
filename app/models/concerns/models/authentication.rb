module Concerns::Models::Authentication
  extend ActiveSupport::Concern

  included do

    # Пропускаем валидацию у гостей
    def email_required?
      super && !guest?
    end

    def password_required?
      super && !guest?
    end

    def move_to(new)
      # Переносим почтовые адреса
      postal_addresses.each do |postal_address|
        postal_address.user = new
        postal_address.save!
      end

      # Переносим автомобили
      cars.each do |car|
        car.user = new
        car.save!
      end

      # Переносим заказы
      orders.each do |order|
        order.user = new
        order.save!
      end

      # Переносим товары
      products.each do |product|
        product.user = new
        product.save!
      end
    end
  end
end
