#encoding: utf-8

module ProductsHelper
  extend ActiveSupport::Concern

  included do

    def redirect_to_relative_path status
      user, order = nil
      if params[:user_id]
        user = User.find(params[:user_id])
      end
      if params[:order_id]
        order = Order.find(params[:order_id])
      end
      redirect_to polymorphic_path([:admin, user, order, :products], :status => status)
    end


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
        when 'active'
          products = products.active
        when 'checked'
          products = products.where('id IN (?)', session[:products] && session[:products].keys)
      end

      products
      
    end


    # Проверка выделения хотя бы одной позиции
    def products_any_checked_validation
      if @products.blank?
        raise ValidationError.new "Ни одна позиция не выделена"
      end
    end


    # Проверка допустимости статуса
    def products_all_statuses_validation valid_statuses
      @products.map(&:status).each do |status|
        unless valid_statuses.include? status
          raise ValidationError.new "Данное действие невозможно осуществить для позиций, находящихся в статусе \"#{Rails.configuration.products_status[status]['title']}\". Допустимые исходные статусы только: #{valid_statuses.map{|status| '"' + Rails.configuration.products_status[status]['title'] + '"'}.join(', ')}"
        end
      end
    end


    # Проверка принадлежности товаров одному покупателю
    def products_belongs_to_one_user_validation!

      first_user = @products.first.user

      @products.each do |product|
        unless product.user == first_user
          raise ValidationError.new "Выбранные позиции должны принадлежать одному покупателю, а сейчас: '#{product.user.to_label}' и '#{first_user.to_label}'"
        end
      end

    end

    # Проверка наличия у всех позиций поставщиков и принадлежности позиций одному поставщику
    def products_belongs_to_one_supplier_validation!

      unless @products.all?{|p| p.supplier}
        raise ValidationError.new "Как минимум одна из позиций не имеет поставщика. Невозможно обрабатывать одновременно товары у которых указан поставщик и у которых нет."
        return errors
      end

      first_supplier = @products.first.supplier

      @products.each do |product|
        unless product.supplier == first_supplier
          raise ValidationError.new "Позиции должны принадлежать одному поставщику, а сейчас: '#{product.supplier.to_label}' и '#{first_supplier.to_label}'"
        end
      end

    end

    def products_only_one_validation
      if @products.size != 1
        raise ValidationError.new "Для данной операции необходимо чтобы был выделена только 1 позиция."
      end
    end
  end
end
