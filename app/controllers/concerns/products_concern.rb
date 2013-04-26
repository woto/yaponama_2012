#encoding: utf-8

module ProductsConcern
  extend ActiveSupport::Concern
  include GridConcern

  included do

    before_action :set_resource_class
    before_action :set_grid_class
    # TODO потом может multiple_destroy вынесу в отдельный контроллер
    before_action :set_grid, :only => [:index, :filter, :multiple_destroy]

    helper_method :products_user_order_tab_scope

    private

    def redirect_to_relative_path status, order = nil
      redirect_to smart_route({:prefix => [:status], :postfix => [:products]}, :status => status, :order_id => (@order && @order.id || params[:order_id]), :user_id => params[:user_id])
    end


    # Сужение области по покупателю и заказу на основе текущего местоположения (адреса страницы) менеджера,
    # а так же таба (отдельные случаи - виртуальные табы all и checked)
    def products_user_order_tab_scope products, status

      products = products.limit(100).offset(0)

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

    def set_grid_class

      @grid_class = Class.new(AbstractGrid)

      columns_hash = {}

      columns_hash['id'] = {
        :type => :single_integer
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

      if admin_zone?
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

      if params[:status].blank? || params[:status] == 'all'
        columns_hash['status'] = {
          :type => :set,
          :set => Hash[*Rails.configuration.products_status.map{|k, v| [v['title'], k]}.flatten],
        }
      end

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

      if admin_zone?
        columns_hash['notes_invisible'] = {
          :type => :string,
        }
      end


      if admin_zone?
        # Мы не можем здесь не добавлять user'а, т.к. может возникнуть ситуация когда мы переходим по многостраничным 
        # редактированиям, где рано или поздно возникают user_id. Например при просмотре всех товаров и оформлении заказа.
        # unless @user
          columns_hash['user_id'] = {
            :type => :belongs_to,
            :belongs_to => User,
          }
        # end
      end

      columns_hash['creator_id'] = {
        :type => :belongs_to,
        :belongs_to => User,
      }

      if admin_zone?
        unless params[:order_id]
          columns_hash['order_id'] = {
            :type => :belongs_to,
            :belongs_to => Order,
          }
        end
      end

      if admin_zone?

        columns_hash['supplier_id'] = {
          :type => :belongs_to,
          :belongs_to => Supplier,
        }
      
      end

      @grid_class.const_set("COLUMNS", columns_hash)

    end

    def additional_conditions

      if @user
        @items = @items.where(:user_id => @user.id)
      end

      if params[:status] != 'all' && params[:status].present?
        @items = @items.where(:status => params[:status]) 
      end

      if params[:order_id]
        @items = @items.where(:order_id => params[:order_id])
      end

    end

    def set_preferable_columns

      @grid.id_visible = '1'
      @grid.short_name_visible = '1'
      @grid.sell_cost_visible = '1'
      @grid.quantity_ordered_visible = '1'
      @grid.manufacturer_visible = '1'
      @grid.catalog_number_visible = '1'
      @grid.updated_at_visible = '1'


      unless @user
        @grid.user_id_visible = "1"
      end

      if ['inorder', 'ordered', 'pre_supplier', 'post_supplier', 'stock', 'complete'].include?(params[:status]) && params[:order_id].blank?
        @grid.order_id_visible = '1'
      end

      if ['post_supplier'].include? params[:status]
        @grid.supplier_id_visible = '1'
      end

      if params[:status].blank? || ['all'].include?(params[:status])
        @grid.status_visible = '1'
      end

    end

    def set_resource_class
      @resource_class = Product
    end

  end

end
