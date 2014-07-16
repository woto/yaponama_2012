# encoding: utf-8
#
module ProductParent

  extend ActiveSupport::Concern

  included do

    before_action do
      if params[:product_id].present?
        # TODO если родительский товар удален и мы редактируем этот,
        # у которого родительский товар указан на удаленный, то тут
        # происходит ошибка
        begin
          @somebody = @user = Product.find(params[:product_id]).somebody
        rescue
        end
      end
    end

  end

end
