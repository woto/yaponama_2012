class Admin::Deliveries::OptionsController < ApplicationController
  include Admin::Admined

  private

  def set_resource_class
    @resource_class = ::Deliveries::Option
  end

end
