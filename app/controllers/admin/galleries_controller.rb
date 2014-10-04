class Admin::GalleriesController < ApplicationController
  include Admin::Admined
  include Grid::Gallery

  skip_before_filter :set_grid, only: [:new, :create, :edit, :update, :show, :destroy]

  private

  def set_resource_class
    @resource_class = Gallery
  end
end
