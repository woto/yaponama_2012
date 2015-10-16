class User::Orders::DeliveriesController < User::Orders::AbstractController

  private

  def set_resource_class
    @resource_class = ::Orders::DeliveryForm
  end

  def resource_params
    super.permit(
        { user_form_attributes: [:name, :email, :phone, :id] },
        :postal_address_id,
        { new_postal_address_attributes: [:is_moscow, :postcode, :region, :city, :street, :house, :stand_alone_house, :room] },
        :notes)
  end

end
