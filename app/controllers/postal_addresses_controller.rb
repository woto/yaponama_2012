# encoding: utf-8
#
class PostalAddressesController < ProfileablesController
  include GridPostalAddress

  private 

  def set_resource_class
    @resource_class = PostalAddress
    @postal_address_type =  'postal_addresses'
  end

end
