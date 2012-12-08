# encoding: utf-8

class Admin::Products::CompleteController < Admin::ProductsController

  before_filter do 
    begin

      @products = products_user_order_tab_scope( Product.scoped, 'checked' )
      products_any_checked_validation
      products_all_statuses_validation ['stock']
      products_belongs_to_one_user_validation!

    rescue ValidationError => e
      redirect_to :back, :alert => e.message
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

      @products.first.user.account.credit -= client_credit
      @products.first.user.account.debit -= client_debit
      @products.first.user.account.save

    end

    redirect_to_relative_path('complete')

  end
end
