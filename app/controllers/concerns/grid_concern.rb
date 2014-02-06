# encoding: utf-8
#
module GridConcern
  extend ActiveSupport::Concern

  included do

    skip_before_filter :find_resource, :only => [:columns, :filters]

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

        # Проба избавиться от постоянной отправки выделенных столбцов
        unless params[:columns]
          # Восстанавливаем ..._visible на старые, т.к. их не меняем
          @grid_class::COLUMNS.each do |column_name, column_settings| 
            if old_grid.instance_variable_get("@visible_#{column_name}") == '1'
              @grid.instance_variable_set("@visible_#{column_name}", '1')
            end
          end
        end

        # TODO Аналогично с фильтрами, ОБЪЕДИНИТЬ С НИЖНИМ БЛОКОМ. Пока сделано так, т.к. это
        # наиболее логически правильный способ (на вскидку) В любом случае необходимо устранить задваивание

        # Это тут не надо, т.к. другой фильтр тогда будет сбрасывать выставленный ранее
        # unless params[:filters]

          @grid_class::COLUMNS.each do |column_name, column_settings|

            next unless visible_columns.include? column_name

            case column_settings[:type]

              when :catalog_number
                if params["grid"].try(:key?, "filter_#{column_name}_like")
                  like = @grid.instance_variable_get("@filter_#{column_name}_like")
                else
                  like = old_grid.instance_variable_get("@filter_#{column_name}_like")
                end

                @grid.instance_variable_set("@filter_#{column_name}_like", like)

              when :string
                if params["grid"].try(:key?, "filter_#{column_name}_like")
                  like = @grid.instance_variable_get("@filter_#{column_name}_like")
                else
                  like = old_grid.instance_variable_get("@filter_#{column_name}_like")
                end

                @grid.instance_variable_set("@filter_#{column_name}_like", like)

              when :single_integer
                if params["grid"].try(:key?, "filter_#{column_name}_single_integer")
                  single_integer = @grid.instance_variable_get("@filter_#{column_name}_single_integer")
                else
                  single_integer = old_grid.instance_variable_get("@filter_#{column_name}_single_integer")
                end

                @grid.instance_variable_set("@filter_#{column_name}_single_integer", single_integer)

              when :number
                if params["grid"].try(:key?, "filter_#{column_name}_from") || params["grid"].try(:key?, "filter_#{column_name}_to")
                  from = @grid.instance_variable_get("@filter_#{column_name}_from")
                  to = @grid.instance_variable_get("@filter_#{column_name}_to")
                else
                  from = old_grid.instance_variable_get("@filter_#{column_name}_from")
                  to = old_grid.instance_variable_get("@filter_#{column_name}_to")
                end

                @grid.instance_variable_set("@filter_#{column_name}_from", from)
                @grid.instance_variable_set("@filter_#{column_name}_to", to)

              when :boolean
                if params["grid"].try(:key?, "filter_#{column_name}_boolean")
                  boolean = @grid.instance_variable_get("@filter_#{column_name}_boolean")
                else
                  boolean = old_grid.instance_variable_get("@filter_#{column_name}_boolean")
                end

                @grid.instance_variable_set("@filter_#{column_name}_boolean", boolean)

              when :checkbox
                if params["grid"].try(:key?, "filter_#{column_name}_checkbox")
                  checkbox = @grid.instance_variable_get("@filter_#{column_name}_checkbox")
                else
                  checkbox = old_grid.instance_variable_get("@filter_#{column_name}_checkbox")
                end

                @grid.instance_variable_set("@filter_#{column_name}_checkbox", checkbox)

              when :set
                if params["grid"].try(:key?, "filter_#{column_name}_set")
                  set = @grid.instance_variable_get("@filter_#{column_name}_set")
                else
                  set = old_grid.instance_variable_get("@filter_#{column_name}_set")
                end

                @grid.instance_variable_set("@filter_#{column_name}_set", set)

              when :belongs_to
                if params["grid"].try(:key?, "filter_#{column_name}_belongs_to")
                  belongs_to = @grid.instance_variable_get("@filter_#{column_name}_belongs_to")
                else
                  belongs_to = old_grid.instance_variable_get("@filter_#{column_name}_belongs_to")
                end

                @grid.instance_variable_set("@filter_#{column_name}_belongs_to", belongs_to)

              when :date
                if params["grid"].try(:key?, "filter_#{column_name}_from") || params["grid"].try(:key?, "filter_#{column_name}_to")
                  from = @grid.instance_variable_get("@filter_#{column_name}_from")
                  to = @grid.instance_variable_get("@filter_#{column_name}_to")
                else
                  from = old_grid.instance_variable_get("@filter_#{column_name}_from")
                  to = old_grid.instance_variable_get("@filter_#{column_name}_to")
                end

                @grid.instance_variable_set("@filter_#{column_name}_from", from)
                @grid.instance_variable_set("@filter_#{column_name}_to", to)

            end

          end

        #end



        unless params[:items]
          # Восстанавливаем item_ids на старые, т.к. их не меняем
          @grid.item_ids = old_grid.item_ids
        end

        unless params[:per_page]
          # Восстанавливаем per_page, т.к. его не меняем
          @grid.per_page = old_grid.per_page
        end

        if [:filters, :per_page].any?{ |p| params[p] }
          # Редиректим на первую, если меняем кол-во эл-ов на странице или применяем фильтр
          redirect_to( smart_route({:prefix => [:filter], :postfix => [@resource_class.to_s.pluralize.underscore]}, :user_id => params[:user_id], :order_id => params[:order_id], :page => 1, :status => params[:status], :primary_key => params[:primary_key], return_path: params[:return_path]))
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

          redirect_to url_for(:primary_key => params[:primary_key], return_path: params[:return_path])

        end

      end

      # ПЕРЕПИСЫВАЕМ НА ПОЛУЧЕННЫЕ
      
      if request.GET[:sort_column]
        @grid.sort_column = params[:sort_column]
      elsif params[:grid] && params[:grid][:sort_column]
      elsif old_grid && old_grid.sort_column
        @grid.sort_column = old_grid.sort_column
      else
        @grid.sort_column = "id"
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

            like = eval("@grid.filter_#{column_name}_like")

            if like.present?
              @items = @items.where(arel[column_name.to_sym].matches("%#{like}%"))
              unless admin_zone?
                @items = @items.where(arel[:hide_catalog_number].not_eq(true))
              end
              mark_as_filter_enabled(column_name)
            end

          when :string

            like = eval("@grid.filter_#{column_name}_like")

            if like.present?
              @items = @items.where(arel[column_name.to_sym].matches("%#{like}%"))
              mark_as_filter_enabled(column_name)
            end

          when :single_integer

            single_integer = eval("@grid.filter_#{column_name}_single_integer")

            if single_integer.present?
              @items = @items.where(arel[column_name.to_sym].eq(single_integer))
              mark_as_filter_enabled(column_name)
            end

          when :number

            from = eval("@grid.filter_#{column_name}_from")

            if from.present?
              @items = @items.where(arel[column_name.to_sym].gteq(from))
              mark_as_filter_enabled(column_name)
            end

            to = eval("@grid.filter_#{column_name}_to")

            if to.present?
              @items = @items.where(arel[column_name.to_sym].lteq(to))
              mark_as_filter_enabled(column_name)
            end

          when :boolean

            boolean = eval("@grid.filter_#{column_name}_boolean")

            if boolean.present?
              @items = @items.where(arel[column_name.to_sym].eq(boolean))
              mark_as_filter_enabled(column_name)
            end

          when :checkbox

            checkbox = eval("@grid.filter_#{column_name}_checkbox")

            if checkbox.present?

              if (keys = @grid.item_ids.select{ |k, v| v == '1' }.keys).any?
                case checkbox
                when '1'
                  @items = @items.where('id IN (?)', @grid.item_ids && keys)
                when '0'
                  @items = @items.where('id NOT IN (?)', @grid.item_ids && keys)
                end
              else
                @items = @items.none
              end

              mark_as_filter_enabled(column_name)
            end

          when :set

            set = eval("@grid.filter_#{column_name}_set")

            if set.respond_to?(:reject) && set.map(&:to_s).reject(&:empty?).present?
              @items = @items.where(arel[column_name.to_sym].in(set))
              mark_as_filter_enabled(column_name)
            end

          when :belongs_to

            belongs_to = eval("@grid.filter_#{column_name}_belongs_to")

            if belongs_to.respond_to?(:reject) && belongs_to.map(&:to_s).reject(&:empty?).present?
              @items = @items.where(arel[column_name.to_sym].in(belongs_to))
              mark_as_filter_enabled(column_name)
            end

          when :date

            from = eval("@grid.filter_#{column_name}_from")

            if from.present?
              from = Time.zone.parse(from)
              @items = @items.where(arel[column_name.to_sym].gteq(from))
              mark_as_filter_enabled(column_name)
            end

            to = eval("@grid.filter_#{column_name}_to")

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
    @grid.instance_variable_set("@filter_enabled_#{column_name}", true)
  end

end
