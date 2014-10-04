# encoding: utf-8
#
class NamesController < ProfileablesController
  include Grid::Name

  private

  def set_resource_class
    @resource_class = Name
  end

end
