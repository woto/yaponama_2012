class Admin::Products::CompleteController < Admin::ProductsController

  before_filter do 
    @products = products_user_order_tab_scope( Product.scoped, 'checked' )

    if @products.blank?
      redirect_to :back, :alert => "None products selected" and return
    end

    unless @products.all?{|product| product.status == 'stock'}
      redirect_to :back, :alert => 'At least one product not in status stock' and return
    end

    if ( errors = products_belongs_to_one_user_validation(@products) ).present?
      redirect_to :back, :alert => errors and return
    end
  end


  def index
    @products_sell_cost = @products.inject(0){|summ, p| summ += p.sell_cost * p.quantity_ordered}
  end


  def create
    client_credit = params[:client_credit].to_d
    client_debit = params[:client_debit].to_d

    ActiveRecord::Base.transaction do
      @products.each do |product|
        product.status = 'complete'
        product.status_will_change!
        unless product.save
          redirect_to :back, :alert => product.errors.full_messages and return
        end
      end

      @products.first.user.account.credit -= credit
      @products.first.user.account.debit -= debit
      @products.first.user.account.save

    end

    redirect_to_relative_path('complete')

  end
end
