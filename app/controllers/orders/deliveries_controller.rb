class Orders::DeliveriesController < DeliveriesController

  def edit
  end

  def show
    redirect_to(polymorphic_path([*jaba3, :order], { id: params[:id], return_path: params[:return_path] }))
  end

end
