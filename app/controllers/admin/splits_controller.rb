# encoding: utf-8
#
class Admin::SplitsController < SplitsController

  include Admin::Admined
  include SetResourceClassDummy
  include NewResourceDummy
  include FindResourceDummy
  include CreateResourceDummy
  include ProductParent

  def new
    @resource = Split.new(:product_id => params[:product_id])
  end

  def create
    @resource = Split.new(resource_params)

    respond_to do |format|
      if @resource.save
        format.js { redirect_to(url_for(action: :show), attention: "Товар успешно разбит на партии. Пожалуйста обновите страницу чтобы увидеть результат операции.") }
      else
        format.js { render action: 'new' }
      end
    end
  end

  def resource_params
    params.require(:split).permit(:product_id, :quantity)
  end

end
