# encoding: utf-8
#
class Admin::PagesController < PagesController
  include Admin::Admined

  def new_resource
    super

    if params[:path].present?
      @resource.path = CGI::unescape(params[:path])
    end
  end

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

  def set_resource_class
    @resource_class = Page
  end

  def find_resource
    @resource = @resource_class.find(params[:id])
  end

end
