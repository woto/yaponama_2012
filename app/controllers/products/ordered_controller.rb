# encoding: utf-8

class Products::OrderedController < ApplicationController
  include ProductsConcern
  include GridConcern

  before_action :set_resource_class
  before_action :set_grid_class
  before_action :set_grid

  before_filter do 
    begin

      Rails.application.routes.recognize_path params[:return_path]
      @items = products_user_order_tab_scope( @items, 'checked' )
      products_any_checked_validation
      products_all_statuses_validation ['inorder', 'cancel']
      products_belongs_to_one_user_validation!

      # TODO Раньше все что ниже было в index. Пока перекинул сюда, чтобы валидация Cash обрабатывалась.
      @current_debit = @user.account.debit
      current_credit = @user.account.credit

      after_credit = (current_credit + @items.inject(0){|sum, item| sum += item.sell_cost * item.quantity_ordered}).round(2)
      @after_debit = (current_credit * @user.prepayment / 100 + @items.inject(0){|sum, item| sum += item.sell_cost * item.quantity_ordered} * @user.prepayment / 100).round(2)

      # TODO Это вакханалия. Переделать с использованием кеширования на уровне заказа(?)
      @after_debit_magic = 
        ( (@user.products.active.includes(:order => :delivery).where(:deliveries => {:full_prepayment_required => true}).summa) + 
        (@user.products.active.includes(:order => :delivery).where(:deliveries => {:full_prepayment_required => false}).summa * @user.prepayment / 100) +
        (Product.includes(:order => :delivery).where(:deliveries => {:full_prepayment_required => true}).where("products.id IN (#{@items.map{|item| item.id}.join(',')})").summa) +
        (Product.includes(:order => :delivery).where(:deliveries => {:full_prepayment_required => false}).where("products.id IN (#{@items.map{|item| item.id}.join(',')})").summa * @user.prepayment / 100)).round(2)

    rescue ValidationError => e
      redirect_to params[:return_path], :alert => e.message
    end

  end

  def index
    @cash = Cash.new(:debit => @after_debit_magic - @current_debit)
  end

  def create
    # TODO необходима проверка значения
    #unless params[:client_debit].to_f.to_s == params[:client_debit]
    #  redirect_to params[:return_path], :alert => "Введено неправильное значение в качестве суммы." and return
    #end

    @cash = Cash.new(cash_params)

    if @cash.valid?
      ActiveRecord::Base.transaction do
        account = @items.first.user.account

        if @cash.debit.to_d != 0
          AccountTransaction.create(:account => account, :debit => @cash.debit, :comment => @cash.comment)
        end

        @items.each do |item|
          item.status = 'ordered'
          unless item.save
            redirect_to params[:return_path], :alert => item.errors.full_messages and return
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
