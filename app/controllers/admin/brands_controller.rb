class Admin::BrandsController < ApplicationController
  include Admin::Admined

  private

  def set_resource_class
    @resource_class = Brand
  end

end
