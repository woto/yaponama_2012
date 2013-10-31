#encoding: utf-8

class Admin::PagesController < PagesController
  include Admin::Admined

  ## GET /pages
  ## GET /pages.json
  #def index
  #  respond_to do |format|
  #    format.html
  #    format.js { render 'grid_filter' }
  #  end
  #end

  ## GET /pages/1
  ## GET /pages/1.json
  #def show
  #  #@resource = Page.find(params[:id])
  #end

  def new_resource
    super

    if params[:path].present?
      @resource.path = CGI::unescape(params[:path])
    end
  end

  ## PUT /pages/1
  ## PUT /pages/1.json
  #def update
  #  #@resource = Page.find(params[:id])

  #  respond_to do |format|
  #    if @resource.update(resource_params)
  #      format.html { redirect_to admin_page_path(@resource), notice: 'Страница успешно обновлена' }
  #    else
  #      format.html { render action: "edit" }
  #    end
  #  end
  #end

  ## DELETE /pages/1
  ## DELETE /pages/1.json
  #def destroy
  #  #@resource = Page.find(params[:id])
  #  @resource.destroy

  #  respond_to do |format|
  #    format.html { redirect_to admin_pages_url }
  #  end
  #end

  def transactions

    transactions = PageTransaction

    if params[:id]
      transactions = PageTransaction.where(:page_id => params[:id])
    end

    @transactions = transactions.order("id DESC").page(params[:page])

    respond_to do |format|
      format.html { render 'profileables/transactions' }
      format.json { render json: @transactions }
    end
  end


  private

  #def page_params
  #  params.require(:page).permit!
  #end

  def find_resource
    @resource = @resource_class.find(params[:id])
  end

  def user_set
    @somebody = @user = User.find(params[:user_id]) if params[:user_id]
  end

  def somebody_set
  end

  def supplier_set
    @somebody = @supplier = Supplier.find(params[:supplier_id]) if params[:supplier_id]
  end


end
