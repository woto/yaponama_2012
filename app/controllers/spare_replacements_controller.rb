class SpareReplacementsController < ApplicationController
  include Grid::SpareReplacement

  private

  def set_resource_class
    @resource_class = SpareReplacement
  end

end
