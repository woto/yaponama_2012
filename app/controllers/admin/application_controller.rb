class Admin::ApplicationController < ActionController::Base
  layout 'admin'
  protect_from_forgery
  before_filter :prepend_view_paths

  def prepend_view_paths
    prepend_view_path "app/views/admin"
  end

  private


  # Сужение области по покупателю и заказу на основе текущего местоположения (адреса страницы) менеджера,
  # а так же таба (отдельные случаи - виртуальные табы all и checked)
  def products_user_order_tab_scope products, status

    if params[:user_id]
      products = products.where(:user_id => params[:user_id])
    end

    if params[:order_id]
      products = products.where(:order_id => params[:order_id]) 
    end

    case status
      when *Rails.configuration.products_status.select{|k, v| v['real']}.keys
        products = products.where(:status => status)
      when 'checked'
        products = products.where('id IN (?)', session[:products] && session[:products].keys)
    end

    products
    
  end


  def products_validation

    @products = products_user_order_tab_scope( Product.scoped, 'checked' )

    # Нет товаров, нет заказа
    unless @products.present?
      redirect_to :back, :alert => ['Neither products selected'] and return false
    end

    # Проверка принадлежности товаров одному пользователю (независимо с какой страницы был сделан запрос)
    if ( errors = products_belongs_to_one_user_validation(@products) ).present?
     redirect_to :back, :alert => errors and return false
    end

    # Проверка допустимых статусов товаров для данного действия
    if ( errors = products_in_allowed_statuses_validation(@products) ).present?
      redirect_to :back, :alert => errors and return false
    end

    return true

  end

  # Проверка принадлежности продуктов одному покупателю
  def products_belongs_to_one_user_validation products

    errors = []

    first_user = products.first.user

    products.each do |product|
      unless product.user == first_user
        errors << "Inordered products must be of one user, but there is: '#{product.user.to_label}' and '#{first_user.to_label}'"
      end
    end

    errors

  end

  # Нельзя обрабатывать товар, не находящийся в корзине, либо в заказе
  def products_in_allowed_statuses_validation products

    errors = []

    products.each do |product|
      unless ["incart", "inorder", "ordered"].include? product.status
        errors << "At least one product has status not in incart, inorder or ordered."
      end
    end

    errors

  end


end
