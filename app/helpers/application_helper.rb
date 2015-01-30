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

  def brand_preview brand

    if brand.preview.present?
      output = ''
      output << h(brand.preview)
      output << ' '
      link = "/#{CGI.escape(brand.name)}"
      output << link_to('подробнее...', link)
      output.html_safe
    end

  end

  def brands_decorator path, brand, options

    title = ""
    if options[:title] == true
      title = brand.name
    end

    # TODO Это странно, но при первой загрузке все ок, а в дальнешем 
    # (видимо из-за Turbolinks) относительный url(/...) перестает работать 
    # TODO туту был и будет fit_thumb_...?
    if brand.image.present?
      image = asset_url(brand.image.url.to_s)
    else
      image = asset_url('no_brand.png')
    end

    link_to(title, path.call(brand), :style => "background: url(#{image}) no-repeat scroll center center", :class => "brand brands-#{brand.name}")

  end

  def sortable(column_name, title, options )
    title ||= column_name.titleize
    direction = column_name.to_s == @grid.sort_column && @grid.sort_direction == 'asc' ? 'desc' : 'asc'
    css_class =  "text-warning" if column_name == @grid.sort_column
    link_to url_for(params.merge(:sort_column => column_name, :sort_direction => direction)), options.merge({id: "sort_#{column_name}",  :class => "ignoredirty #{css_class}", :remote => true}) do
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
    css_class = 'col-md-24'

    container do

    [

    content_tag(:div, :class => 'row top-space-lg') do
      res = ''.html_safe

      if (admin_zone? && @somebody) || !admin_zone?
        css_class = 'col-lg-23 col-lg-push-1 col-md-23 col-md-push-1'
      end

      res <<

      content_tag(:div, :class => css_class) do

        content_tag(:div, :id => 'main', &block)
      
      end

      res << 

      if @somebody

        content_tag(:div, :class => 'col-md-1 col-md-pull-23 col-lg-1 col-lg-pull-23') do

          content_tag :div, id: 'sidebar' do

            "<div class='row'><div class='col-xs-12'>".html_safe +
            content_tag(:ul, class: 'list-unstyled') do
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
                { :title => '<div class="btn btn-success" style="padding: 5px"><i class="fa fa-user fa-fw"></i></div>'.html_safe,
                  #:catch => [ {:action => 'show' }, { action: :edit  }, { controller: 'passwords', action: 'edit', :id => @somebody.id } ], 
                  :catch => [ /\/user$|\/admin\/users\/\d+$/ ], 
                  :link => polymorphic_path([(admin_zone? ? :admin : nil), (admin_zone? ? @somebody : :user)]),
                  :class => 'bottom-space-sm',
                  :dropdown => []
                },

                { :title => '<div class="btn btn-success" style="padding: 5px"><i class="fa fa-truck fa-fw"></i></div>'.html_safe,
                  :catch => [ /\/orders/ ], 
                  :link => '#',
                  :class => 'dropdown bottom-space-sm',
                  :dropdown => _build_dropdowns('order', 'orders', Rails.configuration.orders_status, Rails.configuration.orders_menu, @somebody)
                },

                { :title => '<div class="btn btn-success" style="padding: 5px"><i class="fa fa-shopping-cart fa-fw"></i></div>'.html_safe,
                  :catch => [/^(?!.*orders).*products/],
                  :link => '#',
                  :class => 'dropdown bottom-space-sm',
                  :dropdown => aaa
                },

              ]

              links.collect do |item|

                render_menu(item)

              end.join.html_safe
            end +
            "</div></div>".html_safe
          end
        end
      end

    end].join.html_safe

    end

  end

  def render_menu item
    link = url_for(item[:link])

    if item[:dropdown].blank?
      content_tag :li, link.present? ? link_to(item[:title], link) : '', :class => "#{highlight_active2(item[:catch])} #{item[:class]}"
    else
      content_tag :li, :class => "#{highlight_active2(item[:catch])} #{item[:class]}" do
        [
          ( link_to(item[:title], link, class: "dropdown-toggle", "data-toggle" => 'dropdown').to_s ),

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
    html_escape("#{((value = value.to_i) > 0) ? value.to_s + " дн.".html_safe : 'В наличии'}")
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

  def alert type, dismissable=true, options={}, &block
    #
    # TODO
    # Муть какая-то, разобраться, почему в виде есть разница между do .. end и { "" } и как надо правильно?
    # В таком вариенте работает в обоих случаях.

    if dismissable
      css_class = "alert-dismissable"
    else
      css_style = ["border-top: none; border-right: none; border-bottom: none; border-left-width: 5px; border-radius: 0;", options[:style] ].compact
    end

    options[:class] = ["alert alert-#{type} #{css_class} fade in", options[:class] ].compact
    options[:style] = css_style

    content_tag :div, options do

      if dismissable
        a = capture do
          content_tag(:button, :type=>"button", :class=>"close", :data=>{:dismiss=>"alert"}, :"aria-hidden"=>"true") { "×" }
        end
      end

      b = capture do
        #block.call
        yield
      end

      a.to_s.html_safe + b.to_s.html_safe

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

  def highlight_active2(routes)
    routes = [routes].flatten

    if routes.map{|route| request.fullpath =~ route}.any?
      'active'
    else
      ''
    end
  end


  #def breadcrumb_divider
  #  content_tag(:span, '/', :class => 'divider')
  #end

  def breadcrumb flag, exception=false

    str4 = capture do yield(Breadcrumb.new(self)) end

    content_tag(:ol, :class => 'breadcrumb') do
      str1 = capture do Breadcrumb.new(self).item(icon('home').html_safe, admin_zone? ? admin_path : root_path) end

      unless exception
        if @somebody
          str2 = capture do Breadcrumb.new(self).item('Личный кабинет', jaba3) end
        end
      end

      if flag
        if ['new', 'edit', 'show'].include? params[:action]
          str3 = capture do 
            add = :index if ActiveSupport::Inflector.pluralize(@resource_class.to_s.underscore).eql? @resource_class.to_s.underscore
            Breadcrumb.new(self).item(t("helpers.titles.#{@resource_class.to_s.underscore}.index"), 
                                      polymorphic_path([*jaba3, @resource_class.to_s.underscore.parameterize.underscore.pluralize, add]))
          end
          #polymorphic_path([*jaba3, params['controller'].camelize.demodulize.underscore.to_sym])
          #t("helpers.titles.#{params['controller'].camelize.demodulize.underscore.singularize}.index")
        end
      end

      [str1, str2, str3, str4].join.html_safe

    end
  end

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
      [content_tag(:h1, class: 'bottom-space-xs') do
        h(@meta_title) +
        " " +
        content_tag(:small) do
          h(@meta_title_small)
        end
      end,
      content_tag(:div, class: 'text-muted text-sm') do
        h(@meta_title_lead) 
      end].join.html_safe
    end
  end

  def btn_toolbar
    content_tag :div, class: "btn-toolbar" do
      yield
    end
  end

  def row options={}
    options[:class] = ['row', options[:class] ].compact
    content_tag :div, options do
      yield
    end
  end

  def container options={}
    options[:class] = ['container', options[:class] ].compact
    content_tag :div, options do
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
    options[:class] = ['dropdown', options[:class] ].compact
    content_tag :li, options do
      yield Dropdown.new(self)
    end
  end

  def caret
    content_tag :span, '', class: 'caret ignoredirty'
  end

  def divider
    content_tag :li, '', class: 'divider'
  end

  def jaba
     { 
      :user_id => params[:user_id], 
      :supplier_id => params[:supplier_id], 
      :order_id => params[:order_id], 
      :primary_key => params[:primary_key], 
      :status => params[:status], 
      #:return_path => params[:return_path]
     }
  end

  def jaba2
    @resource_class.name.pluralize.underscore.gsub('/', '_').to_sym
  end

  ['index', 'new', 'edit', 'show'].each do |method_name|
    define_method "title_#{method_name}" do
      @meta_title = t("helpers.titles.#{@resource_class.to_s.underscore}.#{method_name}")
      page_header
    end
  end

  def c0 options={}
    options[:class] = ['col-lg-12 col-md-14 col-sm-16', options[:class] ].compact
    content_tag :div, options do
      yield
    end
  end

  def c1 options={}
    options[:class] = ['col-lg-14 col-md-16 col-sm-18', options[:class] ].compact
    content_tag :div, options do
      yield
    end
  end

  def c2 options={}
    options[:class] = ['col-lg-20 col-md-22 col-sm-24', options[:class] ].compact
    content_tag :div, options do
      yield
    end
  end



  def b1
    container do
      row class: 'top-space bottom-space' do
        content_tag :div, class: 'col-lg-24' do
          yield
        end
      end
    end
  end

  def mark_first_as_active
    if @first.blank?
      @first = true
      'active'
    end
  end

  def opts_checkbox name, part, resource_class
    Rails.application.config_for("application/#{resource_class.name.underscore}")["#{resource_class.name.demodulize.underscore}_#{name}"]['checkboxes'].find{|hash| hash[:value].to_i == instance_eval("part.#{resource_class.name.demodulize.underscore}.#{name}.to_i")}[:label] + " " +
    Rails.application.config_for("application/#{resource_class.name.underscore}")["#{resource_class.name.demodulize.underscore}_#{name}"]['si'].to_s
  end

end
