# encoding: utf-8

class Products::OrderedController < ApplicationController
  include ProductsHelper

  before_filter do 
    begin

      Rails.application.routes.recognize_path params[:return_path]
      @products = products_user_order_tab_scope( Product.order("updated_at DESC"), 'checked' )
      products_any_checked_validation
      products_all_statuses_validation ['inorder', 'cancel']
      products_belongs_to_one_user_validation!

    rescue ValidationError => e
      redirect_to :back, :alert => e.message
    end

  end

  def index
    @user = @products.first.user
    @current_debit = @user.account.debit
    current_credit = @user.account.credit

    after_credit = (current_credit + @products.inject(0){|sum, product| sum += product.sell_cost * product.quantity_ordered}).round(2)
    @after_debit = (current_credit * @user.prepayment_percent / 100 + @products.inject(0){|sum, product| sum += product.sell_cost * product.quantity_ordered} * @user.prepayment_percent / 100).round(2)

    # TODO Это вакханалия. Переделать с использованием кеширования на уровне заказа(?)
    @after_debit_magic = 
      ( (@user.products.active.includes(:order => :delivery).where(:deliveries => {:full_prepayment_required => true}).summa) + 
      (@user.products.active.includes(:order => :delivery).where(:deliveries => {:full_prepayment_required => false}).summa * @user.prepayment_percent / 100) +
      (Product.includes(:order => :delivery).where(:deliveries => {:full_prepayment_required => true}).where("products.id IN (#{@products.map{|product| product.id}.join(',')})").summa) +
      (Product.includes(:order => :delivery).where(:deliveries => {:full_prepayment_required => false}).where("products.id IN (#{@products.map{|product| product.id}.join(',')})").summa * @user.prepayment_percent / 100)).round(2)
  end

  def create
    # TODO необходима проверка значения
    #unless params[:client_debit].to_f.to_s == params[:client_debit]
    #  redirect_to :back, :alert => "Введено неправильное значение в качестве суммы." and return
    #end

    # Тут через Cash сделать
    client_debit = params[:client_debit].to_d

    ActiveRecord::Base.transaction do
      account = @products.first.user.account
      MoneyTransaction.create(:account => account, :debit => client_debit)

      @products.each do |product|
        product.status = 'ordered'
        unless product.save
          redirect_to :back, :alert => product.errors.full_messages and return
        end
      end
    end

    redirect_to_relative_path('ordered')

  end

end
