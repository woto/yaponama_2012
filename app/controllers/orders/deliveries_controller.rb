class Orders::DeliveriesController < DeliveriesController

  def edit
    ugly_address
  end

  def show
    redirect_to(polymorphic_path([*jaba3, :order], { id: params[:id], return_path: params[:return_path] }))
  end

  def set_resource_class
    super
    @postal_address_type = 'orders/deliveries'
  end

  def find_resource
    @resource = @resource_class.find_by_token(params[:id])
  end


end
