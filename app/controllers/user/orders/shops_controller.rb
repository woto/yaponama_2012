class User::Orders::ShopsController < User::Orders::AbstractController

  private

  def set_resource_class
    @resource_class = ::Orders::ShopForm
  end

  def resource_params
    super.permit(
        { user_form_attributes: [:name, :email, :phone, :id] },
        :deliveries_place_id,
        :notes)
  end

end
