class BotsController < ApplicationController
  include GridBot

  skip_before_filter :set_grid, only: [:new, :create, :edit, :update, :show, :destroy]

  private

  def set_resource_class
    @resource_class = Bot
  end

end
