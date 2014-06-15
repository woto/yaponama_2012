class PingController < ApplicationController

  def create
    @current_user.touch

    if Talk.where("id > ?", params[:talk_item_id]).length > 0
      render 'create'
    else
      render nothing: true
    end

  end

  private

  def set_resource_class
    @resource_class = Somebody
  end

end
