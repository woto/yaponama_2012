class Admin::GalleriesController < ApplicationController
  include Admin::Admined

  private

  def set_resource_class
    @resource_class = Gallery
  end
end
