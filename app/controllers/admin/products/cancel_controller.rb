# encoding: utf-8

class Admin::Products::CancelController < Admin::ProductsController

  before_filter do 
    begin

      Rails.application.routes.recognize_path params[:return_path]
      @products = products_user_order_tab_scope( Product.order("updated_at DESC"), 'checked' )
      products_any_checked_validation
      products_belongs_to_one_user_validation!

      # Если хотя бы у одной позиции есть поставщик, то он должен быть у всех и именно такой же
      if @products.any?(&:supplier)
        products_belongs_to_one_supplier_validation!
      end

      # У обрабатываемых позиций должен быть один и тот же статус
      if (statuses = @products.map(&:status).uniq).size > 1
        raise ValidationError.new "У обрабатываемых позиций должен быть один и тот же статус, а сейчас: #{statuses.map{|status| '"' + Rails.configuration.products_status[status]['title'] + '"'}.join(', ')}"
      end

    rescue ValidationError => e
      redirect_to :back, :alert => e.message
    end

  end


  def index
    @products_sell_cost = @products.inject(0){|summ, p| summ += p.sell_cost * p.quantity_ordered}
    @products_buy_cost = @products.inject(0){|summ, p| summ += p.buy_cost * p.quantity_ordered}
  end


  def create
    supplier_credit = params[:supplier_credit].to_d if params[:supplier_credit]
    supplier_debit = params[:supplier_debit].to_d if params[:supplier_debit]
    client_credit = params[:client_credit].to_d if params[:client_credit]
    client_debit = params[:client_debit].to_d if params[:client_debit]

    ActiveRecord::Base.transaction do
      @products.each do |product|
        product.status = 'cancel'
        product.status_will_change!
        unless product.save
          redirect_to :back, :alert => product.errors.full_messages and return
        end
      end

      if supplier_credit.present? || supplier_debit.present?
        @products.first.supplier.account.credit -= supplier_credit
        @products.first.supplier.account.debit -= supplier_debit
        @products.first.supplier.account.save
      end

      if client_credit.present? || client_debit.present?
        @products.first.user.account.credit -= client_credit
        @products.first.user.account.debit -= client_debit
        @products.first.user.account.save
      end

    end

    redirect_to_relative_path('cancel')

  end
end
