class User::PostalAddressesController < ApplicationController

  private

  def set_resource_class
    @resource_class = PostalAddress
  end

  def new_resource
    super
    @resource.is_moscow = true if current_user.ipgeobase_name == 'Москва'
  end

  def create_resource
    @resource = @resource_class.new(resource_params.merge(user: current_user, creator: current_user))
  end

  def resource_params
    params.fetch(:postal_address, {}).permit("is_moscow", "postcode","region", "city", "street", "house", "stand_alone_house", "room", "notes")
  end

end
