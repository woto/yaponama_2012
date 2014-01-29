# encoding: utf-8
#
class Admin::Deliveries::OptionsController < Deliveries::OptionsController
  include Admin::Admined
  include GridOption

  skip_before_filter :set_grid, only: [:new, :create, :edit, :update, :show, :destroy]

  private

  def set_resource_class
    @resource_class = Deliveries::Option
  end

end
