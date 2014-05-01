# encoding: utf-8
#
module GridHelper

  def some(item)
    content = capture do
      content_tag :small do
        content_tag :ul, class: 'list-unstyled' do
          available_columns.reject do |attribute| 
            visible_columns.include? attribute
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

  def grid_row(item)
    content_tag_for(:tr, item) do
      [(
        if visible_columns.include? 'checkbox'
        content_tag(:td, class: "grid-checkbox") do
          hidden_field_tag("grid[item_ids[#{item.id}]", '0') +
          check_box_tag("grid[item_ids[#{item.id}]]", '1', @grid.item_ids.present? && @grid.item_ids[item.id.to_s] == '1', :class => 'item')
        end
      end),
      #(Rails.cache.fetch([item, visible_columns, admin_zone?]) do
      (
        visible_columns.map do |column_name|
          if column_name != 'checkbox'
            content_tag :td, class: "grid-#{column_name}" do
              grid_item_decorator(item, column_name)
            end
          end
        end.join.html_safe
        )].join.html_safe
    end
  end

  def grid_item_decorator(item, column_name)

      #Rails.cache.fetch([item, column_name, admin_zone?]) do
 
      if (m = item.respond_to?(column_name.to_sym))
        m = item.method(column_name.to_sym)
        val = m.call
      end

      content_tag_for(:span, item, column_name, :class => column_name) do
        case column_name
        when 'inet'
          val.inspect.scan(/#<IPAddr: IPv4:(.*)>/)[0][0]
        # READ ONLY
        when *['content', 'user_agent', 'accept_language', 'path', 'title', 'cached_location', 'first_referrer', 'cached_referrer']
          new_val = truncate(val, length: 40)
          content_tag :span, (new_val != val ? {data: { title: val }, rel: 'tooltip'} : {} ) do
            truncate val, length: 40
          end
        # EDITABLE
        when *['name', 'short_name', 'long_name']
          new_val = truncate(val, length: 20)
          content_tag :span, (new_val != val ? {data: { title: val }, rel: 'tooltip'} : {} ) do
            if admin_zone?
              link_to_fast_edit(new_val, item, column_name)
            else
              new_val
            end
          end
        when *['id', 'token']
          link_to item[column_name], '#', data: {html: true, title: 'Информация об элементе', placement: 'right', :"poload" => polymorphic_path([:info, (admin_zone? ? :admin : :user), item], :primary_key => params[:primary_key], :return_path => request.fullpath, :status => params[:status] ) }, class: "btn btn-primary btn-xs ignoredirty", style: "min-width: 30px"
        when 'checkbox'
        when 'cached_profile'
          truncate(strip_tags(parsed_cached_profile(val)), length: 20)
        when 'cached_order'
          if val
            link_to val, polymorphic_path([*jaba3, :order], {id: val})
          end
        when *['notes']
          link_to_fast_edit val, item, column_name
        when *['notes_invisible', 'cached_brand']
          if admin_zone?
            link_to_fast_edit val, item, column_name
          else
            val
          end
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
            if admin_zone?
              link_to_fast_edit "Да", item, column_name
            else
              'Да'
            end
          elsif val == false
            if admin_zone?
              link_to_fast_edit "Нет", item, column_name
            else
              'Нет'
            end
          else 
            raise "true/false тип boolean не выставлен #{@resource_class}. #{column_name}"
          end
        when *['catalog_number']
          res = "".html_safe
          if item.class == Product
            if item.hide_catalog_number
              if admin_zone?
                res << h(val)
              end
              res << " " << content_tag(:sup, icon('asterisk text-muted', :title => 'Каталожный номер скрыт', :rel => 'tooltip'))
            else
              res << val
            end

            if admin_zone?
              link_to_fast_edit res, item, column_name
            else
              res
            end
          else
            res << val
          end
        when *['probability', 'discount', 'prepayment']
          if admin_zone?
            if val.present?
              link_to_fast_edit("#{val}%", item, column_name)
            else
              link_to_fast_edit("", item, column_name)
            end
          else
            if val.present?
              "#{val}%"
            else
              ''
            end
          end
        when *['quantity_available']
          if admin_zone?
            link_to_fast_edit(plain_quantity(val), item, column_name)
          else
            plain_quantity(val)
          end
        when *['quantity_ordered']
          if val.present? && ( ['incart', 'inorder'].include?(item.status) || admin_zone? )
            link_to_fast_edit("#{val} шт.", item, column_name)
          else
            plain_quantity(val)
          end
        when *['min_days', 'max_days']
          if admin_zone?
            if val.present?
              link_to_fast_edit "#{val} дн.", item, column_name
            else
              link_to_fast_edit "", item, column_name
            end
          else
            if val.present?
              "#{val} дн."
            else
              ''
            end
          end
        when *['debit', 'credit', 'cached_debit', 'cached_credit']
          number_to_currency(val, precision: 0)
        when *['sell_cost', 'buy_cost']
          val = number_to_currency(val, precision: 0)
          if admin_zone?
            link_to_fast_edit(val, item, column_name)
          else
            val
          end
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

    #end

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
    content_tag(:ul, :class => "list-unstyled bottom-space-none") do
      arr.collect{ |item| content_tag(:li, h(item)) }.join.html_safe
    end
  end

  def plain_quantity(val)
    if val.present?
      "#{val} шт."
    end
  end

  def link_to_fast_edit content, item, column_name
    link_to polymorphic_path([:fast_edit, (admin_zone? ? :admin : :user), item], :primary_key => params[:primary_key], :return_path => request.fullpath, :status => params[:status], :column => column_name  ), remote: true, class: "dashed" do
      content.presence || icon('plus-square-o')
    end
  end

  def parsed_cached_profile val
    res = []
    begin
      JSON.parse(val).tap do |cached_profile|
        cached_profile["names"].each do |cached_name|
          res << refactor_cached_name(cached_name)
        end
        cached_profile["phones"].each do |cached_phone|
          res << refactor_cached_value(cached_phone)
        end
        cached_profile["emails"].each do |cached_email|
          res << refactor_cached_value(cached_email)
        end
        cached_profile["passports"].each do |cached_passport|
          res << refactor_cached_passport(cached_passport)
        end
      end
      refactor_mmm(res)
    rescue
    end
  end

end
