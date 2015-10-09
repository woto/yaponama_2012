class User::CartController < ApplicationController

  def confirm_remove
    @resource = Product.find(params[:id])
    @resource.destroy
    find_resources
    render 'update'
  end

  def update
    @resource = Product.find(params[:id])
    respond_to do |format|
      format.js do
        case params[:button]
        when 'plus'
          @resource.increment!(:quantity_ordered)
          find_resources
          render 'update'
        when 'minus'
          if @resource.quantity_ordered > 1
            @resource.decrement!(:quantity_ordered)
            find_resources
            render 'update'
          else
            render 'ask_remove'
          end
        end
      end
    end
  end

  private

  def set_resource_class
    @resource_class = Product
  end

  def find_resources
    @resources = current_user.products.incart.order(id: :desc)
  end

end
