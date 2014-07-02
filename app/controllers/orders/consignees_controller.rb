class Orders::ConsigneesController < OrdersController

  def edit
    if @somebody.profiles.any?
      @resource.profile_type = 'old'
    else
      @resource.profile_type = 'new'
    end

    # TODO тут будет так: Если в предыдущем шаге выбрали доставку где требуется паспорт, то будет показвыать по-умолчанию паспорт
    # т.е. будт смотреться то ли на заказ, то ли на delivery_options passport_requred через связи

    @resource.new_profile = @somebody.profiles.new.tap{|p| p.names.new; p.phones.new.tap{|p| p.mobile = true}; p.emails.new}

    #@resource.old_profile = @resource.profile
    #@resource.old_profile_id = @resource.profile_id

  end

  def show
    redirect_to(polymorphic_path([*jaba3, :order], { id: params[:id] }))
  end

end
