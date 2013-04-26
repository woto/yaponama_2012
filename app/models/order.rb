#encoding: utf-8

class Order < ActiveRecord::Base
  include BelongsToUser
  include BelongsToCreator
  include Transactionable

  belongs_to :delivery
  belongs_to :name
  belongs_to :phone
  belongs_to :postal_address
  belongs_to :metro
  belongs_to :company
  belongs_to :shop

  has_many :products, :dependent => :destroy

  def to_label
    "#{id} - #{delivery.try(:to_label)} - #{name.try(:to_label)} - #{postal_address.try(:to_label)} - #{metro.try(:to_label)} - #{shop.try(:to_label)} - #{company.try(:to_label)} - #{phone.try(:to_label)}"
  end

  def update_order_on_products(products)
    products.each do |product|
      product.order = self
      product.status = 'inorder'
      product.save
    end
  end

  validate :multistep_order

  def multistep_order
    unless delivery
      errors.add(:delivery, "Выберите способ доставки")
    else
      if delivery.postal_address_required && postal_address.blank?
        errors.add(:postal_address, "Пожалуйста укажите почтовый адрес")
      end
      if delivery.name_required && name.blank?
        errors.add(:name, "Пожалуйста укажите имя получателя")
      end
      if delivery.phone_required && phone.blank?
        errors.add(:phone, "Пожалуйста укажите номер телефона")
      end
      if delivery.metro_required && metro.blank?
        errors.add(:metro, "Пожалуйста укажите станцию метро")
      end
      if delivery.shop_required && shop.blank?
        errors.add(:shop, "Пожалуйста выберите магазин")
      end
      if delivery.company_required && company.blank?
        errors.add(:company, "Пожалуйста выберите компанию")
      end
      if delivery.delivery_cost_required && delivery_cost.blank?
        errors.add(:delivery_cost, "Пожалуйста укажите предполагаемую сумму доставки")
      end
    end
  end

end
