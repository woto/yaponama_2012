
# encoding: utf-8
#
class Products::InorderController < ApplicationController
  #include ProductsConcern

  before_filter do
    raise 'ЭТО УЖЕ НЕ ИСПОЛЬЗУЕТСЯ!!! todo todo TODO'
    begin

      # TODO Отвалилось возможно в связи с переходом с Rails 4.2.0 beta2 на beta4
      #Rails.application.routes.recognize_path params[:return_path]
      @items = @items.selected(@grid.item_ids)
      any_checked_validation
      products_belongs_to_one_user_validation!
      products_all_statuses_validation ["incart", "inorder", "ordered", "pre_supplier", 'cancel']

    rescue ValidationError => e
      redirect_to params[:return_path], :alert => e.message
    end

  end


  def index
  end

  def order
    # Если выбрали новый заказ
    if params[:id] == '-1'
      @order = @user.orders.create
      #redirect_to smart_route({:prefix => [:legal], :postfix => [:products, :inorder]}, :id => @order.token, :user_id => params[:user_id], :primary_key => params[:primary_key], :return_path => params[:return_path])
      redirect_to smart_route({:prefix => [:delivery], :postfix => [:products, :inorder]}, :id => @order.token, :user_id => params[:user_id], :primary_key => params[:primary_key], :return_path => params[:return_path])

    # Если ничего не выбрали
    elsif params[:id].blank?
      redirect_to smart_route({:postfix => [:products, :inorder_index]}, :user_id => params[:user_id], :order_id => params[:order_id], :primary_key => params[:primary_key], :return_path => params[:return_path]), :alert => 'Пожалуйста выберите имеющийся заказ или создайте новый' and return

    # Если выбрали существующий заказ
    else
      ActiveRecord::Base.transaction do
        @order = Order.find(params[:id])
        @order.update_order_on_products(@items)
        redirect_to smart_route({:postfix => [:products]}, :user_id => @order.user_id, :order_id => @order.id), :notice => "Товар(ы) были успешно добавлены в существующий заказ."
      end
    end
  end

  def delivery
    @order = Order.find(params[:id])
    if request.patch?
    else
      @deliveries = Delivery.all
    end
  end

  def legal
    @order = Order.find(params[:id])
    if request.patch?
      respond_to do |format|

        @order.assign_attributes(order_params)

        @order.profile.names.each do |name|
          name.creation_reason = 'order'
        end
        @order.profile.phones.each do |phone|
          phone.creation_reason = 'order'
        end
        @order.profile.emails.each do |email|
          email.creation_reason = 'order'
        end
        if @order.legal 
          @order.company.creation_reason = 'order'
        end

        if @order.save
          format.html { redirect_to smart_route({:prefix => [:action], :postfix => [:products, :inorder]}, :id => @order.token, :user_id => params[:user_id], :order_id => params[:order_id], :primary_key => params[:primary_key], :return_path => params[:return_path]) }
          format.json { head :no_content }
        else
          format.html { render :action => "legal" }
          format.json { render :json => @user.errors, :status => :unprocessable_entity }
        end
      end
    else
      unless @order.legal
        @order.legal = false
      end

      @order.profile_type = 'new'

      #uioi
      ##unless @order.profile
      #  profile = @order.build_profile
      #  profile.prepare_profile
      #  profile.phones.first.dont_allow_to_remove_first_phone = true
      ##end


      #uioi
      #@order.company_type = 'new'

      ##unless @order.company
      #  company = @order.build_company
      #  company.prepare_company(@user)
      ##end
    end
  end

  def postal_address
  end

  def name
  end

  def phone
  end

  def email
  end
  
  def metro
  end

  def shop
  end

  def company
  end

  def delivery_cost
  end

  def action
    if request.post?
      ActiveRecord::Base.transaction do
        @order = Order.new(order_params)
        @order.user = @items.first.user
        if @order.save
          @order.update_order_on_products(@items)
          redirect_to smart_route({:postfix => [:products]}, :user_id => @order.user_id, :order_id => @order.id), :notice => "Заказ успешно создан."
        end
      end
    else
      @order = Order.where(:id => params[:id]).first
      unless @order
        @order = Order.new
      end
    end
  end

  def order_params
    params[:order].permit!
  end

end
