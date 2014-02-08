# encoding: utf-8
#
class RobotsTxtController < ApplicationController
  include SetResourceClassDummy

  def index
    render 'index', layout: false
  end

  private

end
