#encoding: utf-8

module ProductsConcern
  extend ActiveSupport::Concern

  included do

    before_action :set_resource_class
    before_action :set_grid_class

    #before_filter :set_item_ids

    helper_method :products_user_order_tab_scope

    def redirect_to_relative_path status
      redirect_to smart_route({:postfix => [:products]}, :order_id => params[:order_id], :user_id => params[:user_id], :status => status, :primary_key => params[:primary_key])
    end


    # Сужение области по покупателю и заказу на основе текущего местоположения (адреса страницы) менеджера,
    # а так же таба (отдельные случаи - виртуальные табы all и checked)
    def products_user_order_tab_scope products, status

      products = products.limit(100).offset(0)

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
          products = products.where('id IN (?)', @grid.item_ids && @grid.item_ids.select{ |k, v| v == '1' }.keys )
      end

      products
      
    end


    # Проверка выделения хотя бы одной позиции
    def products_any_checked_validation
      if @items.blank?
        raise ValidationError.new "Ни одна позиция не выделена"
      end
    end


    # Проверка допустимости статуса
    def products_all_statuses_validation valid_statuses
      @items.map(&:status).each do |status|
        unless valid_statuses.include? status
          raise ValidationError.new "Данное действие невозможно осуществить для позиций, находящихся в статусе \"#{Rails.configuration.products_status[status]['title']}\". Допустимые исходные статусы только: #{valid_statuses.map{|status| '"' + Rails.configuration.products_status[status]['title'] + '"'}.join(', ')}"
        end
      end
    end


    # Проверка принадлежности товаров одному покупателю
    def products_belongs_to_one_user_validation!

      first_user = @items.first.user

      @items.each do |item|
        unless item.user == first_user
          raise ValidationError.new "Выбранные позиции должны принадлежать одному покупателю, а сейчас: '#{item.user.to_label}' и '#{first_user.to_label}'"
        end
      end

      @user = @items.first.user

    end

    # Проверка наличия у всех позиций поставщиков и принадлежности позиций одному поставщику
    def products_belongs_to_one_supplier_validation!

      unless @items.all?{|p| p.supplier}
        raise ValidationError.new "Как минимум одна из позиций не имеет поставщика. Невозможно обрабатывать одновременно товары у которых указан поставщик и у которых нет."
        return errors
      end

      first_supplier = @items.first.supplier

      @items.each do |item|
        unless item.supplier == first_supplier
          raise ValidationError.new "Позиции должны принадлежать одному поставщику, а сейчас: '#{item.supplier.to_label}' и '#{first_supplier.to_label}'"
        end
      end

    end

    def products_only_one_validation
      if @items.size != 1
        raise ValidationError.new "Для данной операции необходимо чтобы был выделена только 1 позиция."
      end
    end


    def set_resource_class
      @resource_class = Product
    end


    def set_grid_class

      @grid_class = Class.new(AbstractGrid)

      columns_hash = {}

      columns_hash['id'] = {
        :type => :belongs_to,
        :belongs_to => Product,
      }

      columns_hash['catalog_number'] = {
        :type => :string,
      }

      columns_hash['manufacturer'] = {
        :type => :string,
      }

      columns_hash['short_name'] = {
        :type => :string,
      }

      columns_hash['long_name'] = {
        :type => :string,
      }

      columns_hash['quantity_ordered'] = {
        :type => :number,
      }

      columns_hash['quantity_available'] = {
        :type => :number,
      }

      columns_hash['min_days'] = {
        :type => :number,
      }

      columns_hash['max_days'] = {
        :type => :number,
      }

      if ["admin", "manager"].include?(current_user.role)

        columns_hash['buy_cost'] = {
          :type => :number,
        }

      end

      columns_hash['sell_cost'] = {
        :type => :number,
      }

      columns_hash['hide_catalog_number'] = {
        :type => :boolean,
      }

      columns_hash['status'] = {
        :type => :set,
        :set => Hash[*Rails.configuration.products_status.map{|k, v| [v['title'], k]}.flatten],
      }

      columns_hash['probability'] = {
        :type => :number,
      }

      columns_hash['product_id'] = {
        :type => :belongs_to,
        :belongs_to => Product,
      }

      columns_hash['created_at'] = {
        :type => :date,
      }

      columns_hash['updated_at'] = {
        :type => :date,
      }

      columns_hash['notes'] = {
        :type => :string,
      }

      if ["admin", "manager"].include?(current_user.role)

        columns_hash['notes_invisible'] = {
          :type => :string,
        }

      end


      if ["admin", "manager"].include?(current_user.role)

        columns_hash['user_id'] = {
          :type => :belongs_to,
          :belongs_to => User,
        }

      end

      columns_hash['creator_id'] = {
        :type => :belongs_to,
        :belongs_to => User,
      }

      if ["admin", "manager"].include?(current_user.role)

        columns_hash['order_id'] = {
          :type => :belongs_to,
          :belongs_to => Order,
        }

      end

      if ["admin", "manager"].include?(current_user.role)

        columns_hash['supplier_id'] = {
          :type => :belongs_to,
          :belongs_to => Supplier,
        }
      
      end

      @grid_class.const_set("COLUMNS", columns_hash)

    end


  end

end