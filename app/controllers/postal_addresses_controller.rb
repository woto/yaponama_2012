class PostalAddressesController < ProfileablesController
  include GridPostalAddress

  private 

  def set_resource_class
    @resource_class = PostalAddress
  end

end
