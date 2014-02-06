# encoding: utf-8
#
class CashesController < ApplicationController

  private

  def set_resource_class
    @resource_class = Cash
  end

end
