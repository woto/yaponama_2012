class PingsController < ApplicationController

  def create
    current_user.touch

    talks = @somebody.talks.order(id: :desc)

    talks.where(read: false).each do |talk|
      # Если отправитель - покупатель, а текущий - продавец
      # Если отправитель - продавец, а текущий - покупатель
      if ( talk.creator.buyer? && current_user.seller? ) || ( talk.creator.seller? && current_user.buyer? )
        talk.read = true
        talk.save
      end
    end

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
