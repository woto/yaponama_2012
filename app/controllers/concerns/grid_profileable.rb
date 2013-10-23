module GridProfileable
  extend ActiveSupport::Concern
  include AbstractGridable

  included do

    private

    def adjust_columns!(columns_hash)

      columns_hash['id'] = {
        :type => :single_integer,
      }

      columns_hash['notes'] = {
        :type => :string,
      }

      if admin_zone?

        columns_hash['notes_invisible'] = {
          :type => :string,
        }

      end

      columns_hash['created_at'] = {
        :type => :date
      }
      columns_hash['updated_at'] = {
        :type => :date
      }

      if admin_zone?

        columns_hash['creation_reason'] = {
          :type => :set,
          :set => eval("Hash[*Rails.configuration.#{@resource_class.name.underscore}_creation_reason.map{|k, v| [v, k]}.flatten]"),
        }

      end

      if admin_zone?

        unless @user
          columns_hash['somebody_id'] = {
            :type => :belongs_to,
            :belongs_to => User,
          }
        end

        columns_hash['creator_id'] = {
          :type => :belongs_to,
          :belongs_to => User,
        }

      end

    end

    def set_preferable_columns
      @grid.id_visible = '1'
      @grid.notes_visible = '1'

      unless @user
        @grid.somebody_id_visible = '1'
      end

    end

    def additional_conditions

      # @items = @items.includes(:somebody)

      if @user
        @items = @items.where(:somebody_id => @user.id)
      end
      
    end

  end

end
