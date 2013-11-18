# encoding: utf-8
#
class PhonesController < ProfileablesController
  include GridPhone

  private

  def set_resource_class
    @resource_class = Phone
  end

end
