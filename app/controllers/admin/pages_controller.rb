class Admin::PagesController < PagesController
  include Admin::Admined

  skip_before_action :verify_authenticity_token
  skip_before_filter :find_resource, only: [:multiple_destroy]
  before_action :preprocess_filter, :only => [:multiple_destroy]

  def show
  end

  def preprocess_filter
    @items = @items.selected(@grid.item_ids)
    #binding.pry
    @ic = ItemCollection.new(item_collection_params)
    @ic.operation = params[:action]
    #binding.pry
    @somebody = @user = @supplier = @ic.user
  end

  def destroy
    #binding.pry
    #@items = @items.selected(@grid.item_ids)
    @items = [@resource]
    #binding.pry
    @ic = ItemCollection.new(item_collection_params)
    @ic.operation = 'multiple_destroy'
    #binding.pry
    @somebody = @user = @supplier = @ic.user
    #binding.pry
    multiple_destroy
  end

  def multiple_destroy
    if @ic.operate
      redirect_to params[:return_path], attention: 'Выбранные страницы успешно удалены.'
    else
      redirect_to params[:return_path], attention: @ic.errors.full_messages
    end
  end

  def create
    super
  end

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

end
