# encoding: utf-8
#
class PhonesController < ProfileablesController
  include Grid::Phone

  private

  def set_resource_class
    @resource_class = Phone
  end

end
