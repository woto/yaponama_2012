# encoding: utf-8
#
module GridProduct
  extend ActiveSupport::Concern
  include AbstractGridable

  included do

    private

    def redirect_to_relative_path status, order = nil
      # TODO должно редиректиться на заказ
      redirect_to smart_route({:prefix => [:status], :postfix => [:products]}, :status => status, :order_id => (@order && @order.id || params[:order_id]), :user_id => params[:user_id])
    end

    def adjust_columns!(columns_hash)

      columns_hash['checkbox'] = {
        :type => :checkbox,
      }

      columns_hash['id'] = {
        :type => :single_integer
      }

      columns_hash['catalog_number'] = {
        :type => :catalog_number,
      }

      columns_hash['cached_brand'] = {
        :type => :string
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

      if params[:status].blank? || ['all', 'active'].include?(params[:status])
        columns_hash['status'] = {
          :type => :set,
          :set => Hash[*Rails.configuration.products_status.select{|k, v| v['real'] == true}.map{|k, v| [v['full_title'], k]}.flatten],
        }
      end

      columns_hash['probability'] = {
        :type => :number,
      }

      columns_hash['product_id'] = {
        :type => :belongs_to,
        :belongs_to => Product,
      }

      created_at(columns_hash)

      updated_at(columns_hash)

      notes(columns_hash)

      notes_invisible(columns_hash)

      somebody_id(columns_hash)

      creator_id(columns_hash)

      if admin_zone?
        unless params[:order_id]
          columns_hash['cached_order'] = {
            :type => :set,
            :set => Order.all.map{|item| [item[:token], item[:token]]},
          }
        end
      end

      supplier_id(columns_hash)

    end

    def additional_conditions

      if @user
        @items = @items.where(:somebody_id => @user.id)
      end

      if @supplier
        @items = @items.where(:supplier_id => @supplier.id)
      end

      case params[:status]
        when *Rails.configuration.products_status.select{|k, v| v['real']}.keys
          @items = @items.where(status: params[:status])
        when 'active'
          @items = @items.active
      end

      if params[:order_id]
        @items = @items.where(:cached_order => params[:order_id])
      end

      @items = @items.includes(:somebody)
      @items = @items.includes(:creator)

    end

    def set_preferable_columns

      @grid.visible_checkbox = '1'
      @grid.visible_id = '1'
      @grid.visible_short_name = '1'
      @grid.visible_sell_cost = '1'
      @grid.visible_quantity_ordered = '1'
      @grid.visible_cached_brand = '1'
      @grid.visible_catalog_number = '1'


      unless @somebody
        @grid.visible_somebody_id = "1"
      end


      if admin_zone?
        if ['inorder', 'ordered', 'pre_supplier', 'post_supplier', 'stock', 'complete'].include?(params[:status]) && params[:order_id].blank?
          @grid.visible_cached_order = '1'
        end
      end

      if admin_zone?
        if ['post_supplier'].include? params[:status]
          @grid.visible_supplier_id = '1'
        end
      end

      if params[:status].blank? || ['all', 'active'].include?(params[:status])
        @grid.visible_status = '1'
      end

    end

  end

end
