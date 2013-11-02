module GridHelper

  def some(item)
    content = capture do
      content_tag :small do
        content_tag :ul, class: 'list-unstyled' do
          available_columns.reject do |attribute| 
            visible_columns.include? attribute
          end.select do |attribute| 
            item[attribute].present?
            #true
          end.map do |k, v| 
            content_tag :li do 
              concat(content_tag(:strong) do
                concat "#{@resource_class.human_attribute_name(k)}: "
              end)
              concat grid_item_decorator(item, k)
            end
          end.join.html_safe
        end
      end
    end
  end

  def grid_item_decorator(item, column_name)
    if column_name == 'checkbox'
      hidden_field_tag("grid[item_ids[#{item.id}]", '0') +
      check_box_tag("grid[item_ids[#{item.id}]]", '1', @grid.item_ids.present? && @grid.item_ids[item.id.to_s] == '1', :class => 'item')
    else
      if (m = item.respond_to?(column_name.to_sym))
        m = item.method(column_name.to_sym)
        val = m.call
      end

      content_tag_for(:span, item, column_name, :class => column_name) do
        case column_name
        when 'content'
          truncate val
        when 'id'
          link_to item.id, '#', data: { html: true, :"poload" => polymorphic_path([:info, (admin_zone? ? :admin : :user), item], :primary_key => params[:primary_key], :return_path => request.fullpath ) }, class: "btn btn-default btn-xs ignoredirty", style: "min-width: 30px"
        when 'checkbox'
        when 'cached_main_profile'
          res = []
          begin
            JSON.parse(val).tap do |cached_main_profile|
              cached_main_profile["names"].each do |cached_name|
                res << refactor_cached_name(cached_name)
              end
              cached_main_profile["phones"].each do |cached_phone|
                res << refactor_cached_value(cached_phone)
              end
              cached_main_profile["emails"].each do |cached_email|
                res << refactor_cached_value(cached_email)
              end
              cached_main_profile["passports"].each do |cached_passport|
                res << refactor_cached_passport(cached_passport)
              end
            end
          rescue
          end
          refactor_mmm(res)
        when 'cached_names'
          res = []
          begin
            JSON.parse(val).try(:each) do |cached_name|
              res << refactor_cached_name(cached_name)
            end
          rescue
          end
          refactor_mmm(res)
        when *['cached_phones', 'cached_emails']
          res = []
          begin
            JSON.parse(val).try(:each) do |cached_phone|
              res << refactor_cached_value(cached_phone)
            end
          rescue
          end
          refactor_mmm(res)
        when 'cached_passports'
          res = []
          begin
            JSON.parse(val).try(:each) do |cached_passport|
              res << refactor_cached_passport(cached_passport)
            end
          rescue
          end
          refactor_mmm(res)
        when 'vin_or_frame'
          Rails.configuration.vin_or_frame[val]
        when 'ownership'
          Rails.configuration.company_ownerships[val]
        when *['hide_catalog_number', 'use_auto_russian_time_zone', 'logout_from_other_places', 'sound', 'online', 'phantom', 'confirmed', 'mobile', 'stand_alone_house']
          if val == true
            "Да"
          elsif val == false
            "Нет"
          else 
            raise "true/false тип boolean не выставлен #{@resource_class}. #{column_name}"
          end
        when *['catalog_number']
          if item.class == Product
            if item.hide_catalog_number
              res = "".html_safe
              if admin_zone?
                res << h(val)
              end
              res << " " << icon('asterisk text-muted')
            else
              val
            end
          end
        when *['probability', 'discount', 'prepayment']
          if val.present?
            "#{val}%"
          end
        when *['quantity_ordered', 'quantity_available']
          if val.present?
            "#{val} шт."
          end
        when *['min_days', 'max_days']
          if val.present?
            "#{val} дн."
          end
        when *['sell_cost', 'buy_cost', 'debit', 'credit', 'cached_debit', 'cached_credit']
          number_to_currency(val)
        when *['cached_russian_time_zone_auto_id', 'russian_time_zone_manual_id']
          Rails.configuration.russian_time_zones[val.to_s]
        when 'order_rule'
          Rails.configuration.somebody_order_rules[val]
        when 'status'
          content_tag(:span, class: "label label-#{val}") do
            instance_eval("Rails.configuration.#{@resource_class.name.underscore.pluralize}_status[val]['title']")
          end
        when 'creation_reason'
          instance_eval("Rails.configuration.#{@resource_class.name.underscore}_creation_reason[val]")
        when 'role'
          Rails.configuration.somebody_roles[val]['title']
        when *['somebody_id']
          if item.somebody.present? 
            if admin_zone?
              link_to icon('user') + " #{item.somebody.to_label}", [:admin, item.somebody]
            else
              icon('user') + " #{item.somebody.to_label}"
            end
          end
        when *['creator_id']
          if item.creator.present? 
            if admin_zone?
              link_to icon('user') + " #{item.creator.to_label}", [:admin, item.creator]
            else
              icon('user') + " #{item.creator.to_label}"
            end
          end
        when *['supplier_id']
          if item.supplier.present?
            link_to icon('hospital') + " #{item.supplier.to_label}", [:admin, item.supplier]
          end
        when *['gender']
          Rails.configuration.genders[val]
        when *['data_vidachi', 'data_rozhdeniya']
          l(val, :format => :long)
        when *['image']
          image_tag val
        when *['created_at', 'updated_at', 'password_reset_sent_at', 'confirmation_datetime']
          if val.present?
            l(val, :format => :short)
          end
        else
          m = item.method(column_name.to_sym)
          m.call.to_s
        end

      end

    end

  end

  #def grid_profile_cached_names(item)
  #  debug item.cached_names
  #end

  #
  #def grid_profile_cached_phones(item)
  #  debug item.cached_phones
  #end
  #
  #def grid_profile_cached_emails(item)
  #  debug item.cached_emails
  #end
  #
  #def grid_profile_cached_passports(item)
  #  debug item.cached_passports
  #end

  #def grid_product_id(item)
  #    #<li>
  #    #  <%= link_to 'Задать вопрос', "#", class: "ignoredirty", rel: "ask-question", data: { topic: "#{item.to_label}"} %>
  #    #</li>
  #  end

  #end

  #def grid_product_product_id(item)
  #  item.product.to_label if item.product
  #  # TODO старая идея с виртуальными(?) столбцами, т.е. чтобы можно было наобор
  #  # найти дочерние товары
  #  #td = item.products.map(&:to_label).join(', ') if item.products
  #end
  #
  #
  #
  #  link_to item.accountable.to_label, [:admin, item.accountable]

  def refactor_cached_name(cached_name)
    [cached_name.try(:[], 'surname'),
    cached_name.try(:[], 'name'),
    cached_name.try(:[], 'patronymic')].join(' ')
  end

  def refactor_cached_value(cached_phone)
    cached_phone.try(:[], 'value')
  end

  def refactor_cached_passport(cached_passport)
    [cached_passport.try(:[], 'seriya'),
    cached_passport.try(:[], 'nomer'),
    cached_passport.try(:[], 'mesto_rozhdeniya')].join(', ')
  end

  def refactor_mmm(arr)
    content_tag(:ul, :class => "list-unstyled") do
      arr.collect{ |item| content_tag(:li, h(item)) }.join.html_safe
    end
  end

end
