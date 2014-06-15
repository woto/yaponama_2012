class PingController < ApplicationController

  def create
    @current_user.touch

    talks = Talk.where(nil)

    # Если еще ни одного сообщения нет,
    # то параметра с последним id не будет
    if params[:talk_item_id].present?
      talks = talks.where("id > ?", params[:talk_item_id])
    end

    if talks.any?
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
