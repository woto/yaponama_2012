class User::PostalAddressesController < ApplicationController

  private

  def set_resource_class
    @resource_class = User::PostalAddress
  end

  def create_resource
    @resource = @resource_class.new(resource_params.merge(user: current_user, creator: current_user))
  end

  def resource_params
    params.require(:user_postal_address).permit("postcode","region", "city", "street", "house", "stand_alone_house", "room", "notes")
  end

end