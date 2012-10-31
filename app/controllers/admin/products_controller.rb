class Admin::ProductsController < Admin::ApplicationController
  def index
    @products = Product.where(:status => params[:status])

    respond_to do |format|
      format.html
    end
  end
end
