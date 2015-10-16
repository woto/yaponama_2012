class Orders::DeliveryForm < Orders::AbstractForm

  attr_accessor :old_postal_address
  attr_accessor :new_postal_address
  attr_accessor :postal_address_id

  validates :new_postal_address, associated: true, if: ->{self.postal_address_id == '-1'}
  validates :postal_address_id, inclusion: { in: ->(foo){foo.allowed}, message: 'укажите адрес доставки' }

  def allowed
    user_form.postal_addresses.pluck(:id).map(&:to_s) + ['-1']
  end

  def new_postal_address_attributes=(params={})
    self.new_postal_address = user_form.postal_addresses.new(params)
  end

  def initialize(params={})
    super
    # Мы всегда запоминаем "выбранный адрес" в select'е
    # Если адресов нет, то это input[type="hidden"]
    self.postal_address_id = params[:postal_address_id]
    # Если добавляют новый адрес
    if postal_address_id == '-1'
      self.new_postal_address_attributes = params[:new_postal_address_attributes]
    # Иначе не выбрали или имеющийся адрес
    else
      self.old_postal_address = user_form.postal_addresses.find(params[:postal_address_id]) if postal_address_id.present?
      is_moscow = true if user_form.ipgeobase_name == 'Москва'
      self.new_postal_address = PostalAddress.new(user: user_form, is_moscow: is_moscow)
    end
  end

  def call
    super
    if valid?

      ActiveRecord::Base.transaction do

        postal_address = 
          if postal_address_id == '-1'
            new_postal_address.tap do |postal_address|
              postal_address.save!
            end
          else
            old_postal_address
          end

        self.order = user_form.orders.create!(postal_address: postal_address)
        user_form.products.incart.where(deliveries_place_id: nil).each do |product|
          product.update!(status: 'inorder', order: order)
        end

      end

      true
    end
  end

end
