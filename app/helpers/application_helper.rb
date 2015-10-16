module ApplicationHelper

  include Ckpages::ApplicationHelper

  def product_css_id(catalog_number, brand)
    "#{catalog_number}-#{brand_css_id(brand)}"
  end

  def brand_css_id(brand)
    brand.to_label.parameterize
  end

  def icon method, options={}
    content_tag :i, '', options.merge(class: "fa fa-#{method}")
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
      output = '<div class="top-space">'
      output << h(brand.preview)
      output << ' '
      output << link_to('подробнее...', brand)
      output << "</div>"
      output.html_safe
    end

  end

  def brands_decorator path, brand, title, options={}

    # TODO Это странно, но при первой загрузке все ок, а в дальнешем 
    # (видимо из-за Turbolinks) относительный url(/...) перестает работать 
    # TODO туту был и будет fit_thumb_...?
    if brand.image.present?
      image = asset_url(brand.image.url.to_s)
    else
      image = asset_url('no_brand.png')
    end

    link_to(title.call(brand), path.call(brand), :style => "background: url(#{image}) no-repeat scroll center center", :class => "brand brands-#{brand.name.parameterize}")

  end

  def sortable(column_name, title, options )
    title ||= column_name.titleize
    direction = column_name.to_s == @grid.sort_column && @grid.sort_direction == 'asc' ? 'desc' : 'asc'
    css_class =  "text-warning" if column_name == @grid.sort_column
    link_to url_for(params.merge(:sort_column => column_name, :sort_direction => direction)), options.merge({id: "sort_#{column_name}",  :class => "ignoredirty #{css_class}", :remote => true, :rel => 'nofollow'}) do
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

  def legacy_somebody_tabs(&block)

    res = ''.html_safe
    css_class = 'col-md-24'

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

  def page(&block)
    capture do
      yield PageTemplate.new(self)
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
       :link => polymorphic_path([:status, :user, plural], :status => k.to_sym, :user_id => somebody),
       :class => v.any? ? 'dropdown-submenu' : '',
       :dropdown => v.any? ? _build_dropdowns(singular, plural, statuses, v, somebody) : []
      }
    end

    return dropdowns
  end

  def page_header
    content_tag :div, class: 'page-header' do
      [content_tag(:h1, class: 'bottom-space-xs') do
        h(@meta_title) +
        (" " if @meta_title_small) +
        (content_tag(:small) do
          h(@meta_title_small)
        end if @meta_title_small)
      end,
      content_tag(:div, class: 'text-muted text-sm') do
        h(@meta_title_lead) 
      end].join.html_safe
    end
  end

  def discourse_head
    d = Discourse.new('head', @discourse)

    content_tag :div, class: "bottom-space" do
      d.get_posts(1) do |post, link_to_edit|
        concat(post)
        if current_user && current_user.seller?
          concat link_to("Редактировать вступление", link_to_edit, class: 'btn btn-warning')
        end
      end

      if current_user && current_user.seller?
        concat " "
        concat link_to("Добавить вступление", d.link_to_new, class: 'btn btn-warning')
      end
    end
  end

  def discourse_body
    discourse = Discourse.new('body', @discourse)

    page do |page|
      page.content do
        discourse.get_posts(1) do |post, link|
          concat(panel('default') do |panel|
            concat(panel.heading do
              panel.title do
                'Статьи с форума'
              end
            end)
            concat(panel.body do
              concat post
              concat link_to('Редактировать статью', link, class: 'btn btn-warning') if current_user && current_user.seller?
            end)
          end)
        end
        concat link_to('Новая статья', discourse.link_to_new, class: 'btn btn-warning') if current_user && current_user.seller?
      end
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

  def caret
    content_tag :span, '', class: 'caret ignoredirty'
  end

  def divider
    content_tag :li, '', class: 'divider'
  end

  ['index', 'new', 'edit', 'show'].each do |method_name|
    define_method "title_#{method_name}" do
      @meta_title = t("helpers.titles.#{@resource_class.to_s.underscore}.#{method_name}")
      page_header
    end
  end

  def mark_first_as_active
    if @first.blank?
      @first = true
      'active'
    end
  end

  def opts_checkbox name, part, resource_class
    Rails.configuration.send("opts_#{resource_class.name.demodulize.underscore}")["#{resource_class.name.demodulize.underscore}_#{name}"]['checkboxes'].find{|hash| hash[:value].to_i == instance_eval("part.#{resource_class.name.demodulize.underscore}.#{name}.to_i")}[:label]
  end

  def si str, model, attribute
    capture do
      concat str
      concat " "
      concat Rails.configuration.send("opts_#{model}")["#{model}_#{attribute}"]['si'].to_s
    end
  end

  def hidden str
    content_tag :div, str, class: 'hidden' 
  end

  def attentioned_news
    get_news.
      select{|topic| topic['pinned']}.
      reject{|topic| topic['closed']}
  end

  def horizontal_simple_form_for(object, *args, &block)
    options = args.extract_options!
    simple_form_for(object, *(args << options.merge({
      html: { class: 'form-horizontal' },
      wrapper: :horizontal_form,
      wrapper_mappings: {
        check_boxes: :horizontal_radio_and_checkboxes,
        radio_buttons: :horizontal_radio_and_checkboxes,
        file: :horizontal_file_input,
        boolean: :horizontal_boolean},
      builder: HorizontalFormBuilder
    })), &block)
  end

  class HorizontalFormBuilder < SimpleForm::FormBuilder
    def horizontal_simple_fields_for(*args, &block)
      options = args.extract_options!
      simple_fields_for(*(args << options.merge({
        wrapper: :horizontal_form,
        wrapper_mappings: {
          check_boxes: :horizontal_radio_and_checkboxes,
          radio_buttons: :horizontal_radio_and_checkboxes,
          file: :horizontal_file_input,
          boolean: :horizontal_boolean
        }})), &block)
    end
  end

end
