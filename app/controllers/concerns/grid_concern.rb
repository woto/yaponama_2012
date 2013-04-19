module GridConcern
  extend ActiveSupport::Concern

  included do

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

        if [:filters, :columns, :per_page].any?{ |p| params[p] }

          # Замещаем item_ids на старые, т.к. их не меняем
          @grid.item_ids = old_grid.item_ids

        end

        if [:filters, :columns, :items].any?{ |p| params[p] }
          # Восстанавливаем per_page, т.к. его не меняем
          @grid.per_page = old_grid.per_page
        end

        if [:filters, :per_page].any?{ |p| params[p] }

          redirect_to( smart_route({:prefix => [:filter], :postfix => [@resource_class.to_s.pluralize.underscore]}, :page => 1, :primary_key => params[:primary_key]))
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

          @grid.per_page = Kaminari.config.default_per_page

          $redis.set("grid:#{params[:primary_key]}", @grid.to_json)

          redirect_to :primary_key => params[:primary_key]

        end

      end

      # ПЕРЕПИСЫВАЕМ НА ПОЛУЧЕННЫЕ
      
      if params[:sort_column]
        @grid.sort_column = params[:sort_column]
      elsif params[:grid] && params[:grid][:sort_column]
      elsif old_grid && old_grid.sort_column
        @grid.sort_column = old_grid.sort_column
      else
        @grid.sort_column = "updated_at"
      end

      if params[:sort_direction]
        @grid.sort_direction = params[:sort_direction]
      elsif params[:grid] && params[:grid][:sort_direction]
      elsif old_grid && old_grid.sort_direction
        @grid.sort_direction = old_grid.sort_direction
      else
        @grid.sort_direction = 'desc'
      end

      if params[:page]
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

          when :string

            like = eval("@grid.#{column_name}_like")
            if like.present?
              @items = @items.where(arel[column_name.to_sym].matches("%#{like}%"))
            end

          when :number

            from = eval("@grid.#{column_name}_from")
            if from.present?
              @items = @items.where(arel[column_name.to_sym].gteq(from))
            end

            to = eval("@grid.#{column_name}_to")
            if to.present?
              @items = @items.where(arel[column_name.to_sym].lteq(to))
            end

          when :boolean

            boolean = eval("@grid.#{column_name}_boolean")
            if boolean.present?
              @items = @items.where(arel[column_name.to_sym].eq(boolean))
            end

          when :set
            set = eval("@grid.#{column_name}_set")
            if set.respond_to?(:reject) && set.map(&:to_s).reject(&:empty?).present?
              @items = @items.where(arel[column_name.to_sym].in(set))
            end

          when :belongs_to
            belongs_to = eval("@grid.#{column_name}_belongs_to")
            if belongs_to.respond_to?(:reject) && belongs_to.map(&:to_s).reject(&:empty?).present?
              @items = @items.where(arel[column_name.to_sym].in(belongs_to))
            end

          when :date

            from = eval("@grid.#{column_name}_from")
            to = eval("@grid.#{column_name}_to")

            if from.present?
              @items = @items.where(arel[column_name.to_sym].gteq(from))
            end

            if to.present?
              @items = @items.where(arel[column_name.to_sym].lteq(to))
            end

        end

      end

      $redis.set("grid:#{params[:primary_key]}", @grid.to_json)

    end

  end

end