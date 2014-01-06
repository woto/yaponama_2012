# encoding: utf-8
#
module ApplicationHelper

  def icon method, options={}
    content_tag :i, '', options.merge(class: "fa fa-#{method}")
  end


  def buy_button offer, catalog_number, manufacturer, short_name, long_name, options
    # TODO Вроде бы title всегда пустой... ? Потом когда вернусь к 'производителю' посмотрю
    link_to '#', options.merge( data: {short_name: short_name, long_name: long_name, cost: offer[:retail_cost], catalog_number: catalog_number, manufacturer: manufacturer, title: offer[:title], count: offer[:count], max_days: offer[:max_days], min_days: offer[:min_days], country: offer[:country], probability: offer[:probability], tech: offer[:tech], income_cost: offer[:income_cost] } ) do
      yield
    end
  end 

  def brand_rating brand

    if brand.brand.present?
      return brand_rating brand.brand
    end

    value = ( brand.try(:[], :rating).to_i || 0 ) / 2000.0
    content_tag(:div, class: "stars") do

      res = "".html_safe

      accum = 0

      value.to_i.downto(2) do |i|
        accum += 1
        res << icon('star fa-lg')
      end

      if value.to_i != value
        accum += 1
        res << icon('star-half-o fa-lg')
      end

      (5 - accum).downto(1) do |i|
        res << icon('star-o fa-lg')
      end

      res

    end

  end

  def brands_decorator brand, options

    if brand.brand.present?
      return raw brands_decorator(brand.brand, options)
    end

    title = ""
    if options[:title] == true
      title = brand.name
    end

    if brand.image.present?
      image = asset_path(brand.image.url.to_s)
    else
      image = asset_path('no_brand.png')
    end

    link_to(title, "/#{CGI.escape(brand.name)}", :style => "background: url(#{image}) no-repeat scroll center center", :class => "brands-#{brand.name}")
  end

  def sortable(column_name, title, options )
    title ||= column_name.titleize
    direction = column_name.to_s == @grid.sort_column && @grid.sort_direction == 'asc' ? 'desc' : 'asc'
    css_class =  "text-warning" if column_name == @grid.sort_column
    link_to url_for(params.merge(:sort_column => column_name, :sort_direction => direction)), options.merge({:class => "ignoredirty #{css_class}", :remote => true}) do
      if column_name.to_s == @grid.sort_column
        if @grid.sort_direction == 'asc'
          icon('sort-desc') + '&nbsp;'.html_safe 
        else
          icon('sort-asc') + '&nbsp;'.html_safe
        end
      else
        #icon('unsorted') + 
        ''.html_safe
      end +
      title
    end
  end

  def somebody_tabs(&block)

    res = ''.html_safe
    css_class = 'col-md-12'

    [

    content_tag(:div, :class => 'row') do
      res = ''.html_safe

      if (admin_zone? && @somebody) || !admin_zone?
        css_class = 'col-md-10 col-md-push-2'
      end

      res <<

      content_tag(:div, :class => css_class) do

        render('searches/like_us') +
        content_tag(:div, :id => 'main', &block)
      
      end

      res << 

      if (admin_zone? || current_user.role != 'guest') && @somebody

        content_tag(:div, :class => 'col-md-2 col-md-pull-10 text-sm') do

          content_tag(:ul, :class => 'nav nav-pills nav-stacked') do
            aaa = _build_dropdowns('product', 'products', Rails.configuration.products_status, Rails.configuration.products_menu, @somebody)

            if admin_zone?
              aaa += 
              [{ :title => '',
                :catch => [],
                :link => '',
                :class => 'divider',
                :dropdown => []
              },
              { :title => "&nbsp;&nbsp;".html_safe << icon('plus') << '&nbsp;&nbsp;Добавить'.html_safe,
                :catch => [],
                :link => new_admin_user_product_path(@somebody, :return_path => request.fullpath, :skip => true),
                :class => '',
                :dropdown => []
              }]
            end

            links = [ 
              { :title => 'Главная',
                :catch => [ {:action => 'show' }, { action: :edit  }, { controller: 'passwords', action: 'edit', :id => @somebody.id } ], 
                :link => polymorphic_path([(admin_zone? ? :admin : nil), (admin_zone? ? @somebody : :user)]),
                :class => '',
                :dropdown => []
              },

              { :title => params[:controller] == 'orders' ? "Заказы&nbsp;<span class='label label-#{params[:status]}'>#{Rails.configuration.orders_status[params[:status]].try(:[], 'title')} </span>".html_safe : "Заказы",
                :catch => [ { :controller => 'orders' } ], 
                :link => '#',
                :class => 'dropdown',
                :dropdown => _build_dropdowns('order', 'orders', Rails.configuration.orders_status, Rails.configuration.orders_menu, @somebody)
              },

              { :title => params[:controller] == 'products' ? "Товары&nbsp;<span class='label label-#{params[:status]}'>#{Rails.configuration.products_status[params[:status]].try(:[], 'title')} </span>".html_safe : "Товары",
                :catch => [ { :controller => 'products' } ],
                :link => '#',
                :class => 'dropdown',
                :dropdown => aaa
              },

              { :title => 'История',
                :catch => [],
                :link => 'http://ya.ru',
                :class => '',
                :dropdown => []
              },

            ]

            links.collect do |item|

              render_menu(item)

            end.join.html_safe
          end +
          "<hr>".html_safe +
          (render 'profileables/right')
        end
      elsif !admin_zone?
        content_tag(:div, :class => 'col-md-2 col-md-pull-10 text-sm') do
          render 'application/right'
        end
      end

    end].join.html_safe

  end

  def render_menu item
    link = url_for(item[:link])

    if item[:dropdown].blank?
      content_tag :li, link.present? ? link_to(item[:title], link) : '', :class => "#{highlight_active(item[:catch])} #{item[:class]}"
    else
      content_tag :li, :class => "#{highlight_active(item[:catch])} #{item[:class]}" do
        [
          ( link_to(item[:title], link, "data-toggle" => item[:class]).to_s ),

          ( content_tag :ul, :class => 'dropdown-menu' do |ul|
            item[:dropdown].collect do |dropdown|
              render_menu dropdown if dropdown
            end.join.html_safe
          end.to_s )
        ].join.html_safe
      end
    end
  end

  def car_identity(request)
    (request.car.vin + " " + request.car.frame + " " + request.car.marka + " " + request.car.model + " " + request.car.god).strip
  end
  
  ##################################3
  # ВЫРЕЗКА СО СТАРОГО
  #
  def days_decorator value
    html_escape("#{((value = value.to_i) > 0) ? value : '*'}") + "&nbsp;дн.".html_safe
  end 
  
  def count_decorator value
    html_escape("#{((value = (value.to_s.gsub(/\D/, '').to_i)) > 0) ? "#{value} шт." : 'Скрыто'}")
  end
  
  def cost_decorator value
    html_escape("#{(value).round.to_s}") + "&nbsp;руб.".html_safe
  end

  def country_decorator value
    value.presence || "Скрыто"
  end


  def phone_decorator value
    value.gsub(/(\d{3})(\d{3})(\d{2})(\d{2})/, '(\1) \2-\3-\4')
  end

  def probability_decorator value
    value.present? ? "#{value.to_i}%" : ""
  end

  def hint_decorator value, add_class=''
    raw "<p><span class=\"label #{add_class}\">К сведению</span> #{value}</p>"
  end

  ##################################3
  # / ВЫРЕЗКА СО СТАРОГО

  def hint &block
    content_tag(:span, class: "help-block") do
      yield
    end
  end

  def alert type, &block
    # TODO
    # Муть какая-то, разобраться, почему в виде есть разница между do .. end и { "" } и как надо правильно?
    # В таком вариенте работает в обоих случаях.
    content_tag :div, class: "alert alert-#{type} alert-dismissable fade in" do

      a = capture do
        content_tag(:button, :type=>"button", :class=>"close", :data=>{:dismiss=>"alert"}, :"aria-hidden"=>"true") { "×" }
      end

      b = capture do
        #block.call
        yield
      end

      a + b
    end

  end

  private


  def highlight_active(routes)
    begin
      if routes.map{|route| current_page?(route)}.any?
        'active'
      else
        ''
      end
    rescue ActionController::UrlGenerationError
    end
  end


  #def breadcrumb_divider
  #  content_tag(:span, '/', :class => 'divider')
  #end

  #def breadcrumb elms
  #  content_tag(:ul, :class => 'breadcrumb') do
  #    index = 0
  #    elms.collect do |k|
  #      if k['condition']
  #        if k['link'].present?
  #          concat content_tag(:li, link_to(k['title'], k['link']))
  #        else
  #          concat content_tag(:li, k['title'], :class => 'active')
  #        end
  #        unless index == elms.size - 1
  #          concat content_tag(:span, '/', :class => 'divider')
  #        end
  #        index += 1
  #      end
  #    end
  #  end
  #end
  
  def _build_dropdowns(singular, plural, statuses, menu, somebody)

    dropdowns = []

    menu.each do |k, v|

      title = ''
      if statuses[k]['badge'].present?
        title << content_tag(:span, statuses[k]['badge'].html_safe, :class => "badge badge-#{k}")
        title << ' '
      else
        title << '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
      end
      title  << statuses[k]['title']

      dropdowns <<
      {
       :title => title.html_safe,
       :catch => [],
       :link => smart_route({:prefix => [:status], :postfix => [plural]}, :status => k.to_sym, :user_id => somebody),
       :class => v.any? ? 'dropdown-submenu' : '',
       :dropdown => v.any? ? _build_dropdowns(singular, plural, statuses, v, somebody) : []
      }
    end

    return dropdowns
  end

  # Тут еще был product_status_decorator, 
  # объединить? TODO посмотреть в хелпере
  def order_status_decorator(status)
    status = status || 'all'
    content_tag(:span, class: "label label-#{status}") do
      Rails.configuration.orders_status[status]['title']
    end
  end

  def order_decorator(order)
    # TODO Пересмотреть
    if order
      link_to smart_route({:postfix => [:order]}, :user_id => order.user_id, :id => order.id, :status => nil) do 
        content_tag(:i, '', class: "icon-shopping-cart").html_safe +
        " " +
        order.to_label 
      end
    end
  end

  def page_header
    content_tag :div, class: 'page-header' do
      content_tag :h1 do
        h(@meta_title) +
        " " +
        content_tag(:small) do
          h(@meta_title_small)
        end
      end
    end
  end

  def btn_toolbar
    content_tag :div, class: "btn-toolbar" do
      yield
    end
  end

  def row
    content_tag :div, class: "row" do
      yield
    end
  end

  def nested_visualize &block
    content_tag :div, class: "nested-visualize" do
      yield
    end
  end

  def twbs_form_for(name, *args, &block)
    options = args.extract_options!
    options[:class] = ['dirtyforms', options[:class] ].compact
    # TODO замутить fieldset disabled?
    #content_tag :fieldset do
    # fieldset должен быть внутри формы
    # убрал form-horizontal
    form_for(name, *(args << options.merge(builder: TwitterBootstrapFormBuilder, html: { class: options[:class] } )), &block)
    #end
  end

  def input_group options={}, &block
    content_tag :div, class: 'input-group' do
      yield InputGroup.new(self)
    end
  end

  def list_group options={}, &block
    content_tag :div, class: 'list-group' do
      yield ListGroup.new(self)
    end
  end

  def panel type, options={}, &block
    options[:class] = ["panel panel-#{type}", options[:class] ].compact
    content_tag :div, options do
      yield Panel.new(self)
    end
  end

  def alert_link_to name = nil, options = nil, html_options = nil, &block
    html_options ||= {}
    html_options[:class] = ['alert-link', html_options[:class] ].compact
    link_to(name, options, html_options, &block)
  end



  def modal options={}, &block
    # TODO
    # Добавить сюда aria-labelledby: "auth-label"
    # А у строки - заголовка - h3, расположенного внутри modal-header id="auth-label" (На данный момент в 3-м bootstrap'e не нашел)
    options[:class] = [ 'modal', options[:class] ].compact
    # К сожалению если раскомментировать, то select2 перестанет работать
    #options[:tabindex] = "-1"
    options[:role] = "dialog"
    options["aria-hidden"] = "true"
    content_tag :div, options do
      content_tag :div, class: "modal-dialog" do
        content_tag :div, class: "modal-content" do
          yield Modal.new(self)
        end
      end
    end
  end

  def dropdown options={}, &block
    content_tag :li, class: 'dropdown' do
      yield Dropdown.new(self)
    end
  end

  def caret
    tag :span, class: 'caret ignoredirty'
  end

  def divider
    tag :li, class: 'divider'
  end

  def jaba
     { 
      :user_id => params[:user_id], 
      :supplier_id => params[:supplier_id], 
      :order_id => params[:order_id], 
      :primary_key => params[:primary_key], 
      :status => params[:status], 
      :return_path => params[:return_path]
     }
  end

  def jaba2
    @resource_class.name.pluralize.underscore.gsub('/', '_').to_sym
  end

  def jaba3
    [
      (admin_zone? ? :admin : :user),
      (admin_zone? ? @somebody : nil)
    ]
  end


  ['index', 'new', 'edit', 'show'].each do |method_name|
    define_method "title_#{method_name}" do
      @meta_title = t("helpers.titles.#{@resource_class.to_s.underscore}.#{method_name}")
      page_header
    end
  end

end
