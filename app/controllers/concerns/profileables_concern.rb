module ProfileablesConcern
  extend ActiveSupport::Concern

  included do

    private

      def set_resource_class
        @resource_class = params[:resource_class].singularize.constantize
      end

    def set_grid_class

      @grid_class = Class.new(AbstractGrid)

      columns_hash = {}

      # Не очень красиво, но рабочее, пересекающихся полей разного типа не планируется
      @resource_class.column_names.each do |column_name|
        case column_name
        when 'phone_type'
          columns_hash[column_name] = {
            :type => :set,
            :set => Hash[*Rails.configuration.phone_types.map{|k, v| [v, k]}.flatten],
          }
        when *['created_at', 'updated_at', 'user_confirmation_datetime', 'manager_confirmation_datetime']
          columns_hash[column_name] = {
            :type => :date
          }
        when *['confirmed_by_user', 'confirmed_by_manager']
          columns_hash[column_name] = {
            :type => :boolean,
          }
        when 'ownership'
          columns_hash[column_name] = {
            :type => :set,
            :set => Hash[*Rails.configuration.company_ownerships.map{|k, v| [v, k]}.flatten],
          }
        when 'id'
          columns_hash[column_name] = {
            :type => :single_integer,
          }
        when 'creation_reason'
          columns_hash[column_name] = {
            :type => :set,
            :set => eval("Hash[*Rails.configuration.user_#{@resource_class.name.underscore}_creation_reason.map{|k, v| [v, k]}.flatten]"),
          }
        when 'notes_invisible'
          if admin_zone?
            columns_hash[column_name] = {
              :type => :string,
            }
          end
        when 'user_id'
          if admin_zone?
            unless @user
              columns_hash['user_id'] = {
                :type => :belongs_to,
                :belongs_to => User,
              }
            end
          end
        else
          columns_hash[column_name] = {
            :type => :string,
          }
        end
      end

      @grid_class.const_set("COLUMNS", columns_hash)
    end

    def set_preferable_columns
      case @resource_class.to_s
      when 'Name'
        @grid.name_visible = '1'
      when 'Phone'
        @grid.phone_visible = '1'
      when 'EmailAddress'
        @grid.email_address_visible = '1'
      when 'PostalAddress'
        @grid.city_visible = '1'
        @grid.house_visible = '1'
        @grid.postcode_visible = '1'
        @grid.region_visible = '1'
        @grid.room_visible = '1'
        @grid.street_visible = '1'
      when 'Car'
        @grid.brand_visible = '1'
        @grid.frame_visible = '1'
        @grid.god_visible = '1'
        @grid.model_visible = '1'
        @grid.vin_visible = '1'
      when 'Company'
        @grid.inn_visible = '1'
        @grid.name_visible = '1'
        @grid.ogrn_visible = '1'
        @grid.ownership_visible = '1'
      end

      @grid.id_visible = '1'
      @grid.notes_visible = '1'

      unless @user
        @grid.user_id_visible = '1'
      end

    end

    def additional_conditions

      if @user
        @items = @items.where(:user_id => @user.id)
      end
      
    end

  end

end
