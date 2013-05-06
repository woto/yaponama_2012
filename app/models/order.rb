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

  before_create :generate_token

  protected

  def generate_token
    self.token = loop do
      # Три случайных числа
      # -
      # День
      # -
      # Месяц
      # Последнее число года
      #
      # 000-00-000
 
      random_token = ''
      random_token += 3.times.map{ [*'0'..'9'].sample }.join
      random_token += '-'
      random_token += DateTime.now.strftime("%d-%m%y")
      random_token = random_token[0..8]+random_token[10]
      #random_token += 3.times.map { [*'0'..'9', *'А'..'Я'].sample }.join
      break random_token unless Order.where(token: random_token).exists?
      #random_token = SecureRandom.urlsafe_base64
      #break random_token unless Order.where(token: random_token).exists?
    end
  end

end
