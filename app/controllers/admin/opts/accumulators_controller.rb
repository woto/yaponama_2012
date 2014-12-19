class Admin::Opts::AccumulatorsController < ApplicationController
  include Admin::Admined
  include Grid::Accumulator

  skip_before_filter :set_grid, only: [:new, :create, :edit, :update, :show, :destroy]

  private

  def set_resource_class
    @resource_class = ::Opts::Accumulator
  end

end
