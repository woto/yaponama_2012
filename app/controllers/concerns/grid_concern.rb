module GridConcern
  extend ActiveSupport::Concern

  included do

    before_action :set_grid

    private

    def set_grid

      # Считываем сохраненный ранее grid
      old_grid = nil
      if params[:primary_key].present?
        old_grid = @grid_class.new(JSON.parse($redis.get("grid:#{params[:primary_key]}")))
      end

      if params[:grid].present?

        # Создаем новый из params
        @grid = @grid_class.new(params[:grid])


        # filters columns per_page items

        unless params[:items]
          # Восстанавливаем item_ids на старые, т.к. их не меняем
          @grid.item_ids = old_grid.item_ids
        end

        unless params[:per_page]
          # Восстанавливаем per_page, т.к. его не меняем
          @grid.per_page = old_grid.per_page
        end

        if [:filters, :per_page].any?{ |p| params[p] }

          redirect_to( smart_route({:prefix => [:filter], :postfix => [@resource_class.to_s.pluralize.underscore]}, :user_id => params[:user_id], :order_id => params[:order_id], :page => 1, :status => params[:status], :primary_key => params[:primary_key]))
        elsif params[:items]
          # Дописываем к ранее сохраненному grid
          if params[:grid][:item_ids]
            @grid.item_ids = old_grid.item_ids.merge( params[:grid][:item_ids] )
          end
        end

      else

        if params[:primary_key].present?

          @grid = @grid_class.new(JSON.parse($redis.get("grid:#{params[:primary_key]}")))

        else 

          # TODO не кошерно
          params[:primary_key] = $redis.incr('grid')

          @grid = @grid_class.new(params[:grid])

          set_preferable_columns

          @grid.per_page = Kaminari.config.default_per_page

          $redis.set("grid:#{params[:primary_key]}", @grid.to_json)

          redirect_to :primary_key => params[:primary_key]

        end

      end

      # ПЕРЕПИСЫВАЕМ НА ПОЛУЧЕННЫЕ
      
      if request.GET[:sort_column]
        @grid.sort_column = params[:sort_column]
      elsif params[:grid] && params[:grid][:sort_column]
      elsif old_grid && old_grid.sort_column
        @grid.sort_column = old_grid.sort_column
      else
        @grid.sort_column = "updated_at"
      end

      if request.GET[:sort_direction]
        @grid.sort_direction = params[:sort_direction]
      elsif params[:grid] && params[:grid][:sort_direction]
      elsif old_grid && old_grid.sort_direction
        @grid.sort_direction = old_grid.sort_direction
      else
        @grid.sort_direction = 'desc'
      end

      if request.GET[:page]
        @grid.page = params[:page]
      elsif params[:grid] && params[:grid][:page]
      elsif old_grid && old_grid.page
        @grid.page = old_grid.page
      else
        @grid.page = '1'
      end

      @items = @resource_class
      @items = @items.page(@grid.page).per(@grid.per_page)
      @items = @items.order(@grid.sort_column + " " + @grid.sort_direction, :id)

      arel = @resource_class.arel_table

      @grid_class::COLUMNS.each do |column_name, column_settings|

        case column_settings[:type]

          when :catalog_number
            like = eval("@grid.#{column_name}_like")
            if like.present?
              @items = @items.where(arel[column_name.to_sym].matches("%#{like}%"))
              unless admin_zone?
                @items = @items.where(arel[:hide_catalog_number].not_eq(true))
              end
              mark_as_filter_enabled(column_name)
            end

          when :string
            like = eval("@grid.#{column_name}_like")
            if like.present?
              @items = @items.where(arel[column_name.to_sym].matches("%#{like}%"))
              mark_as_filter_enabled(column_name)
            end

          when :single_integer
            single_integer = eval("@grid.#{column_name}_single_integer")
            if single_integer.present?
              @items = @items.where(arel[column_name.to_sym].eq(single_integer))
              mark_as_filter_enabled(column_name)
            end

          when :number

            from = eval("@grid.#{column_name}_from")
            if from.present?
              @items = @items.where(arel[column_name.to_sym].gteq(from))
              mark_as_filter_enabled(column_name)
            end

            to = eval("@grid.#{column_name}_to")
            if to.present?
              @items = @items.where(arel[column_name.to_sym].lteq(to))
              mark_as_filter_enabled(column_name)
            end

          when :boolean
            boolean = eval("@grid.#{column_name}_boolean")
            if boolean.present?
              @items = @items.where(arel[column_name.to_sym].eq(boolean))
              mark_as_filter_enabled(column_name)
            end

          when :checkbox

            checkbox = eval("@grid.#{column_name}_checkbox")
            if checkbox.present?
              case checkbox
              when '1'
                @items = @items.where('id IN (?)', @grid.item_ids && @grid.item_ids.select{ |k, v| v == '1' }.keys )
              when '0'
                @items = @items.where('id NOT IN (?)', @grid.item_ids && @grid.item_ids.select{ |k, v| v == '1' }.keys )
              end
              mark_as_filter_enabled(column_name)
            end

          when :set
            set = eval("@grid.#{column_name}_set")
            if set.respond_to?(:reject) && set.map(&:to_s).reject(&:empty?).present?
              @items = @items.where(arel[column_name.to_sym].in(set))
              mark_as_filter_enabled(column_name)
            end

          when :belongs_to
            belongs_to = eval("@grid.#{column_name}_belongs_to")
            if belongs_to.respond_to?(:reject) && belongs_to.map(&:to_s).reject(&:empty?).present?
              @items = @items.where(arel[column_name.to_sym].in(belongs_to))
              mark_as_filter_enabled(column_name)
            end

          when :date

            from = eval("@grid.#{column_name}_from")
            to = eval("@grid.#{column_name}_to")

            if from.present?
              from = Time.zone.parse(from)
              @items = @items.where(arel[column_name.to_sym].gteq(from))
              mark_as_filter_enabled(column_name)
            end

            if to.present?
              to = Time.zone.parse(to)
              @items = @items.where(arel[column_name.to_sym].lteq(to))
              mark_as_filter_enabled(column_name)
            end

        end

      end

      begin
        method(:additional_conditions)
        additional_conditions
      rescue StandardError
      end

      $redis.set("grid:#{params[:primary_key]}", @grid.to_json)

    end

  end

  def default_url_options
    params.delete :grid
    params.delete :utf8
    params.delete :columns
    params.delete :items
    params.delete :filters
    params.delete :per_page
    super
  end


  def mark_as_filter_enabled(column_name)
    @grid.instance_variable_set("@#{column_name}_filter_enabled", true)
  end

end
