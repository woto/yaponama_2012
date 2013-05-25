#encoding: utf-8

module ApplicationHelper

  def sortable(column_name, title, options )
    title ||= column_name.titleize
    direction = column_name.to_s == @grid.sort_column && @grid.sort_direction == 'asc' ? 'desc' : 'asc'
    css_class = (column_name == @grid.sort_column) ? "#{@grid.sort_direction}" : nil
    link_to url_for(params.merge(:sort_column => column_name, :sort_direction => direction)), options.merge({:class => css_class, :remote => true}) do
      if column_name.to_s == @grid.sort_column
        if @grid.sort_direction == 'asc'
          content_tag(:i, '', :class => 'icon icon-sort-up') + '&nbsp;'.html_safe
        else
          content_tag(:i, '', :class => 'icon icon-sort-down') + '&nbsp;'.html_safe
        end
      else
        ''.html_safe
      end +
      title
    end
  end

  def user_tabs(&block)

    res = ''.html_safe
    workspace_class = 'span12'

    content_tag(:div, :class => 'row-fluid') do
      if admin_zone?
        c = 'span8'
        z = 'workspace'
      else
        c = 'span12'
      end
      [(content_tag :div, :id => 'main', :class => c do
        content_tag(:div, :class => 'row-fluid') do
          if @user && admin_zone?
            workspace_class = 'span8'
            res = content_tag(:div, :class => 'span4', :id => 'profile') do
              [(render 'users/show')].join.html_safe
            end
          end

          res <<
          content_tag(:div, :class => workspace_class, :id => z) do

          if @user && admin_zone?

            content_tag(:div, :id => 'profile-button-show', :class => 'profile-button') do
              content_tag(:i, '', :class => "icon icon-double-angle-right")
            end <<

            content_tag(:div, :id => 'profile-button-hide', :class => 'profile-button') do
              content_tag(:i, '', :class => "icon icon-double-angle-left")
            end <<

            content_tag(:ul, :class => 'nav nav-tabs', style: "margin-bottom: 10px") do
              [ 
                { :title => 'Настройки', 
                  :catch => [ { :controller => 'users', :action => 'edit' } ], 
                  :link => {:controller => '/admin/users', :action => 'edit', :id => @user.id},
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
                  :link => '#',
                  :class => 'dropdown',
                  :dropdown => _build_dropdowns('product')
                },

                { :title => 'Транзакции',
                  :catch => [ 
                    { :controller => 'products', :action => 'transactions' }, { :controller => 'accounts', :action => 'transactions' } ],
                  :link => '#', 
                  :class => 'dropdown',
                  :dropdown => [
                    { :title => 'Товар',
                      :catch => [ { :controller => 'products', :action => 'transactions' } ],
                      :link => { :controller => '/admin/products', :action => 'transactions' },
                      :class => '',
                      :dropdown => []
                    },
                    { :title => 'Деньги',
                      :catch => [ { :controller => 'accounts', :action => 'transactions' } ],
                      :link => { :controller => '/admin/accounts', :action => 'transactions' },
                      :class => '',
                      :dropdown => []
                    }
                  ]
                },


                { :title => 'Поиск', 
                  :catch => [ { :controller => 'searches' } ],
                  :link => { :controller => '/searches', :action => 'index' },
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

                            begin
                              link = url_for(dropdown[:link])
                            rescue ActionController::UrlGenerationError
                            end
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
          end.to_s.html_safe <<

          content_tag(:div, :class => "tab-content", style: "min-height: 400px") do
            content_tag(:div, :class => 'tab-pane active', &block)
          end

          
        end
      end.to_s

    end),(

      if @user && admin_zone?
        content_tag(:div, :class => "span4 bottom-space", :id => "sidebar") do
          content_tag(:div, :id => "chat-button-hide", :class => "chat-button") do
            content_tag(:i, '', :class => "icon icon-double-angle-right")
          end <<
          render(:partial => "shared/chat")
        end
      end
    )].join.html_safe

    end

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

  private

  def highlight_active(routes)
    #begin
      if routes.map{|route| current_page?(route)}.any?
        'active'
      else
        ''
      end
    #rescue ActionController::UrlGenerationError
    #end
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
       :link => smart_route({:prefix => [:status], :postfix => [plural]}, :status => k.to_sym, :user_id => @user),
       :class => '',
       :dropdown => []
      }
    end

    return dropdowns
  end

  def product_status_decorator(status)
    status = status || 'all'
    content_tag(:span, class: "label label-#{status}") do
      Rails.configuration.products_status[status]['title']
    end
  end

  def order_status_decorator(status)
    status = status || 'all'
    content_tag(:span, class: "label label-#{status}") do
      Rails.configuration.orders_status[status]['title']
    end
  end

  def order_decorator(order)
    if order
      link_to smart_route({:postfix => [:order]}, :user_id => order.user_id, :id => order.id, :status => nil) do 
        content_tag(:i, '', class: "icon-shopping-cart").html_safe +
        " " +
        order.to_label 
      end
    end
  end

  def account_link_helper(first, second)
    content_tag :span, class: "help-block top-space" do
      "#{first} #{link_to(second, edit_polymorphic_path([ params[:controller].include?('admin') ? [:admin, @user] : [:user]]))}".html_safe
    end
  end

end
