#encoding: utf-8

module OrdersConcern
  extend ActiveSupport::Concern
  include AbstractGridable

  included do


    def set_resource_class
      @resource_class = Order
    end

    def set_grid_class

      @grid_class = Class.new(AbstractGrid)

      @grid_class = Class.new(AbstractGrid)
      @grid_class.instance_eval do
        include ActiveModel::Validations
        def self.model_name
          ActiveModel::Name.new(self, nil, "grid")
        end
      end

      columns_hash = {}

      columns_hash['token'] = {
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

      columns_hash['status'] = {
        :type => :set,
        :set => Hash[*Rails.configuration.orders_status.map{|k, v| [v['title'], k]}.flatten],
      }

      #columns_hash['delivery_id'] = {
      #  :type => :belongs_to,
      #  :belongs_to => Delivery,
      #}


      columns_hash['profile_id'] = {
        :type => :belongs_to,
        :belongs_to => Profile,
      }

      columns_hash['cached_profile'] = {
        :type => :string,
      }

      if admin_zone?
        columns_hash['phantom'] = {
          :type => :boolean,
        }
      end

      columns_hash['legal'] = {
        :type => :boolean,
      }

      columns_hash['created_at'] = {
        :type => :date,
      }

      columns_hash['updated_at'] = {
        :type => :date,
      }

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
          columns_hash['user_id'] = {
            :type => :belongs_to,
            :belongs_to => User,
          }
        end
      end

      columns_hash['creator_id'] = {
        :type => :belongs_to,
        :belongs_to => User,
      }

      @grid_class.const_set("COLUMNS", columns_hash)

    end

    def set_preferable_columns

      @grid.token_visible = '1'
      #@grid.delivery_id_visible = '1'
      @grid.cached_profile_visible = '1'
      @grid.notes_visible = '1'
      @grid.updated_at_visible = '1'

      unless @user
        @grid.user_id_visible = '1'
      end

      if params[:status].blank? || ['all'].include?(params[:status])
        @grid.status_visible = '1'
      end

    end

    def additional_conditions
      if @user
        @items = @items.where(:user_id => @user.id)
      end

      if params[:status] != 'all' && params[:status].present?
        @items = @items.where(:status => params[:status]) 
      end

    end

  end

end

