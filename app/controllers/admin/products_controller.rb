class Admin::ProductsController < Admin::ApplicationController
  def index
    @products = Product.where(:status => :incart)

    respond_to do |format|
      format.html
    end
  end
end
