class PingController < ApplicationController

  def create
    @current_user.touch
    render nothing: true
  end

  private

  def set_resource_class
    @resource_class = Somebody
  end

end
