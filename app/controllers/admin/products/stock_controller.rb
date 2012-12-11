# encoding: utf-8

class Admin::Products::StockController < Admin::ProductsController

  before_filter do 
    begin

      Rails.application.routes.recognize_path params[:return_path]
      @products = products_user_order_tab_scope( Product.scoped, 'checked' )
      products_any_checked_validation
      products_all_statuses_validation ['post_supplier']
      products_belongs_to_one_supplier_validation!

    rescue ValidationError => e
      redirect_to :back, :alert => e.message
    end

  end


  def index
    @products_buy_cost = @products.inject(0){|summ, p| summ += p.buy_cost * p.quantity_ordered}
  end


  def create
    supplier_credit = params[:supplier_credit].to_d
    supplier_debit = params[:supplier_debit].to_d

    ActiveRecord::Base.transaction do
      @products.each do |product|
        product.status = 'stock'
        product.status_will_change!
        unless product.save
          redirect_to :back, :alert => product.errors.full_messages and return
        end
      end

      @products.first.supplier.account.credit -= supplier_credit
      @products.first.supplier.account.debit -= supplier_debit
      @products.first.supplier.account.save
    end

    redirect_to_relative_path('stock')

  end
end
