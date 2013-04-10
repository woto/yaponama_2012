# encoding: utf-8

class Products::OrderedController < ApplicationController
  include ProductsHlp

  before_filter do 
    begin

      Rails.application.routes.recognize_path params[:return_path]
      @products = products_user_order_tab_scope( Product.order("updated_at DESC"), 'checked' )
      products_any_checked_validation
      products_all_statuses_validation ['inorder', 'cancel']
      products_belongs_to_one_user_validation!

      # TODO Раньше все что ниже было в index. Пока перекинул сюда, чтобы валидация Cash обрабатывалась.
      @user = @products.first.user
      @current_debit = @user.account.debit
      current_credit = @user.account.credit

      after_credit = (current_credit + @products.inject(0){|sum, product| sum += product.sell_cost * product.quantity_ordered}).round(2)
      @after_debit = (current_credit * @user.prepayment / 100 + @products.inject(0){|sum, product| sum += product.sell_cost * product.quantity_ordered} * @user.prepayment / 100).round(2)

      # TODO Это вакханалия. Переделать с использованием кеширования на уровне заказа(?)
      @after_debit_magic = 
        ( (@user.products.active.includes(:order => :delivery).where(:deliveries => {:full_prepayment_required => true}).summa) + 
        (@user.products.active.includes(:order => :delivery).where(:deliveries => {:full_prepayment_required => false}).summa * @user.prepayment / 100) +
        (Product.includes(:order => :delivery).where(:deliveries => {:full_prepayment_required => true}).where("products.id IN (#{@products.map{|product| product.id}.join(',')})").summa) +
        (Product.includes(:order => :delivery).where(:deliveries => {:full_prepayment_required => false}).where("products.id IN (#{@products.map{|product| product.id}.join(',')})").summa * @user.prepayment / 100)).round(2)

    rescue ValidationError => e
      redirect_to :back, :alert => e.message
    end

  end

  def index
    @cash = Cash.new(:debit => @after_debit_magic - @current_debit)
  end

  def create
    # TODO необходима проверка значения
    #unless params[:client_debit].to_f.to_s == params[:client_debit]
    #  redirect_to :back, :alert => "Введено неправильное значение в качестве суммы." and return
    #end

    @cash = Cash.new(cash_params)

    if @cash.valid?
      ActiveRecord::Base.transaction do
        account = @products.first.user.account

        if @cash.debit.to_d != 0
          AccountTransaction.create(:account => account, :debit => @cash.debit, :comment => @cash.comment)
        end

        @products.each do |product|
          product.status = 'ordered'
          unless product.save
            redirect_to :back, :alert => product.errors.full_messages and return
          end
        end
      end
    else
      render 'index' and return
    end

    redirect_to_relative_path('ordered')

  end

  private

  def cash_params
    params.require(:cash).permit!
  end

end
