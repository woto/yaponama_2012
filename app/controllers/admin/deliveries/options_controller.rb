# encoding: utf-8
#
class Admin::Deliveries::OptionsController < Deliveries::OptionsController
  include Grid::Option
  include Admin::Admined

  private

  def set_resource_class
    @resource_class = Deliveries::Option
  end

end
