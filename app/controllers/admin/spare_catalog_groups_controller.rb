class Admin::SpareCatalogGroupsController < ApplicationController
  include Admin::Admined

  private

  def set_resource_class
    @resource_class = SpareCatalogGroup
  end

end
