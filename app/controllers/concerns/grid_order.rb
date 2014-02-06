# encoding: utf-8
#
module GridOrder
  extend ActiveSupport::Concern
  include AbstractGridable

  included do

    def adjust_columns!(columns_hash)

      columns_hash['token'] = {
        :type => :string
      }

      columns_hash['delivery_place_id'] = {
        :type => :string
      }

      columns_hash['delivery_variant_id'] = {
        :type => :string
      }

      columns_hash['delivery_option_id'] = {
        :type => :string
      }

      columns_hash['postal_address_id'] = {
        :type => :belongs_to,
        :belongs_to => PostalAddress,
      }

      columns_hash['company_id'] = {
        :type => :belongs_to,
        :belongs_to => Company,
      }

      columns_hash['delivery_cost'] = {
        :type => :number,
      }

      #columns_hash['delivery_id'] = {
      #  :type => :belongs_to,
      #  :belongs_to => Delivery,
      #}

      columns_hash['cached_profile'] = {
        :type => :string,
      }

      phantom(columns_hash)

      columns_hash['legal'] = {
        :type => :boolean,
      }

      created_at(columns_hash)
      updated_at(columns_hash)

      columns_hash['creation_reason'] = {
        :type => :set,
        :set => eval("Hash[*Rails.configuration.#{@resource_class.name.underscore}_creation_reason.map{|k, v| [v, k]}.flatten]"),
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
        unless @user
          columns_hash['somebody_id'] = {
            :type => :belongs_to,
            :belongs_to => User,
          }
        end
      end

      creator_id(columns_hash)

      columns_hash['status'] = {
        :type => :set,
        :set => Hash[*Rails.configuration.orders_status.map{|k, v| [v['title'], k]}.flatten],
      }


    end

    def set_preferable_columns
      
      @grid.visible_delivery_place_id = '1'
      @grid.visible_delivery_variant_id = '1'
      @grid.visible_delivery_option_id = '1'
      @grid.visible_postal_address_id = '1'
      #@grid.visible_ = '1'
      #@grid.visible_ = '1'

      @grid.visible_token = '1'
      #@grid.delivery_id = '1'
      @grid.visible_cached_profile = '1'
      @grid.visible_notes = '1'
      @grid.visible_updated_at = '1'

      unless @user
        @grid.visible_somebody_id = '1'
      end

      if params[:status].blank? || ['all'].include?(params[:status])
        @grid.visible_status = '1'
      end

    end

    def additional_conditions
      if @user
        @items = @items.where(:somebody_id => @user.id)
      end

      if params[:status] != 'all' && params[:status].present?
        @items = @items.where(:status => params[:status]) 
      end

    end

  end

end

