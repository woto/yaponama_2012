#encoding: utf-8

module ApplicationHelper

  def icon method, options={}
    content_tag :i, '', options.merge(class: "fa fa-#{method}")
  end

  def brands_decorator brand, options
    if brand
      if brand.brand
        return raw brand.brands.map{|ref| brands_decorator(ref, options)}
      end

      title = ""
      if options[:title] == true
        title = brand.name.html_safe
      end

      link_to(title, "/brands/#{brand.name}", :style => "width: 50px; height: 50px; display: block; background-image: url(#{asset_path(brand.image.url.to_s)})", :class => "brands-#{brand.name}")
      #brand.content
    end
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
    workspace_class = 'col-md-12'

    ['',

    content_tag(:div, :class => 'row') do
      res = ''.html_safe

      if @somebody
        workspace_class = 'col-md-10 col-md-push-2'
      end

      res <<

      content_tag(:div, :class => workspace_class) do

        if @somebody

          content_tag(:ul, :class => 'nav nav-pills bottom-space') do
            [ 
              { :title => 'Главная', 
                :catch => [ {:action => 'show', :id => @somebody.id, :user_id => nil }, { action: :edit, :id => @somebody.id, :user_id => nil  }, { controller: 'passwords', action: 'edit', :id => @somebody.id } ], 
                :link => polymorphic_path([(admin_zone? ? :admin : nil), (admin_zone? ? @somebody : :user)]),
                :class => '',
                :dropdown => []
              },

              { :title => 'Заказы',  
                :catch => [ { :controller => 'orders' } ], 
                :link => '#',
                :class => 'dropdown',
                :dropdown => _build_dropdowns('order')
              },

              { :title => 'Товары',  
                :catch => [ { :controller => 'products' } ],
                :link => polymorphic_path([(admin_zone? ? :admin : nil), (admin_zone? ? @somebody : :user), :products]),
                :class => '',
                :dropdown => []
              },

            ].collect do |item|

              #begin
                link = url_for(item[:link])
              #rescue ActionController::UrlGenerationError
              #end

              if item[:dropdown].blank? 
                content_tag :li, link_to(item[:title], link), :class => highlight_active(item[:catch])
              else
                content_tag :li, :class => "#{highlight_active(item[:catch])} #{item[:class]}" do
                  [ 
                    ( link_to(item[:title], link, "data-toggle" => item[:class]).to_s ), 

                    ( content_tag :ul, :class => 'dropdown-menu' do |ul|
                      item[:dropdown].collect do |dropdown|

                          #begin
                            link = url_for(dropdown[:link])
                          #rescue ActionController::UrlGenerationError
                          #end
                          content_tag :li, :class => highlight_active(dropdown[:catch]) do
                            link_to(dropdown[:title], link)

                        end
                      end.join.html_safe
                    end.to_s ) 
                  ].join.html_safe
                end
              end
            end.join.html_safe
          end
        end.to_s.html_safe +
        
        content_tag(:div, :class => "tab-content") do
          content_tag(:div, :class => 'tab-pane active', &block)
        end
      
      end

      res << 

      if @somebody
        content_tag(:div, :class => 'col-md-2 col-md-pull-10') do
          (render 'profileables/right')
        end
      end

    end].join.html_safe

  end

  def car_identity(request)
    (request.car.vin + " " + request.car.frame + " " + request.car.marka + " " + request.car.model + " " + request.car.god).strip
  end
  
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


  def probability_decorator value
    value.present? ? "#{value.to_i}%" : ""
  end

  def hint_decorator value, add_class=''
    raw "<p><span class=\"label #{add_class}\">К сведению</span> #{value}</p>"
  end

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
  
  def _build_dropdowns(singular)

    plural = singular.pluralize

    dropdowns = []

    tmp = eval("Rails.configuration.#{plural}_status")

    tmp.each do |k, v|
      title = ''
      if v['badge'].present?
        title << content_tag(:span, v['badge'], :class => "badge badge-#{k}")
        title << ' '
      end
      title  << v['title']

      dropdowns <<
      {
       :title => title.html_safe,
       :catch => [ { :controller => plural, :action => 'index', :status => k.to_sym, :order_id => nil } ],
       :link => smart_route({:prefix => [:status], :postfix => [plural]}, :status => k.to_sym, :user_id => @somebody),
       :class => '',
       :dropdown => []
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
    # TODO замутить fieldset disabled?
    #content_tag :fieldset do
    # fieldset должен быть внутри формы
    # убрал form-horizontal
    form_for(name, *(args << options.merge(builder: TwitterBootstrapFormBuilder, html: { class: "dirtyforms"} )), &block)
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

  def panel type, &block
    content_tag :div, class: "panel panel-#{type}" do
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
    options[:tabindex] = "-1"
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

  ['index', 'new', 'edit', 'show'].each do |method_name|
    define_method "title_#{method_name}" do
      @meta_title = t("helpers.titles.#{@resource_class.to_s.underscore}.#{method_name}")
    end
  end

end
