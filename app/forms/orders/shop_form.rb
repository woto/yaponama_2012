class Orders::ShopForm < Orders::AbstractForm

  attr_accessor :deliveries_place
  attr_accessor :deliveries_place_id

  def initialize(params={})
    super
    self.deliveries_place = Deliveries::Place.find(params[:deliveries_place_id])
    self.deliveries_place_id = params[:deliveries_place_id]
  end

  def call
    super
    if valid?

      ActiveRecord::Base.transaction do

        self.order = user_form.orders.create!(deliveries_place_id: deliveries_place_id)
        user_form.products.incart.where(deliveries_place_id: deliveries_place_id).each do |product|
          product.update!(status: 'inorder', order: order)
        end

      end

      true
    end
  end

end
