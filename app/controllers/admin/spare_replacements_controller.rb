class Admin::SpareReplacementsController < ApplicationController
  include Admin::Admined

  private

  def set_resource_class
    @resource_class = SpareReplacement
  end
end
