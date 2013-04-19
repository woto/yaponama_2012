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

    products_dropdown = []

     Rails.configuration.products_status.each do |k, v|
       title = ''
       if v['badge'].present?
         title << content_tag(:span, v['badge'], :class => "badge badge-#{k}")
         title << ' '
       end
       title  << v['title']

       products_dropdown <<
      {
        :title => title.html_safe,
        :catch => [ { :controller => 'products', :action => 'index', :status => k.to_sym } ],
        :link => { :controller => 'products', :action => 'index', :status => k.to_sym },
        :class => '',
        :dropdown => []
      }
    end


    res = ''.html_safe
    workspace_class = 'span12'

    content_tag(:div, :class => 'row-fluid') do
      if @user && params[:controller].include?('admin')
        workspace_class = 'span9'
        res = content_tag(:div, :class => 'span3') do
          render 'users/show'
        end
      end

      res <<
      content_tag(:div, :class => workspace_class, :id => 'workspace') do
        content_tag(:ul, :class => 'nav nav-tabs') do
          [ 
            { :title => 'Главная', 
              :catch => [ { :controller => 'users', :action => 'edit' } ], 
              :link => {:controller => 'users', :action => 'edit'},
              :class => '',
              :dropdown => []
            },

            { :title => 'Заказы',  
              :catch => [ { :controller => 'orders' } ], 
              :link => { :controller => 'orders', :action => 'index' },
              :class => '',
              :dropdown => []
            },

            { :title => 'Товары',  
              :catch => [ { :controller => 'products' } ],
              :link => '#',
              :class => 'dropdown',
              :dropdown => products_dropdown
            },

            { :title => 'Транзакции',  
              :catch => [ 
                { :controller => 'products', :action => 'transactions' }, { :controller => 'account_transactions' } ],
              :link => '#', 
              :class => 'dropdown',
              :dropdown => [
                { :title => 'Товар',  
                  :catch => [ { :controller => 'products', :action => 'transactions' } ],
                  :link => { :controller => 'products', :action => 'transactions' },
                  :class => '',
                  :dropdown => []
                },
                { :title => 'Деньги',  
                  :catch => [ { :controller => 'account_transactions' } ],
                  :link => { :controller => 'account_transactions', :action => 'index' },
                  :class => '',
                  :dropdown => []
                }
              ]
            },


            { :title => 'Поиск', 
              :catch => [ { :controller => 'searches' } ],
              :link => { :controller => 'searches', :action => 'index' },
              :class => '',
              :dropdown => []
            },

          ].collect do |item|

            begin
              link = url_for(item[:link])
            rescue ActionController::UrlGenerationError
            end

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
        end <<

        content_tag(:div, :class => "tab-content") do
          content_tag(:div, :class => 'tab-pane active', &block)
        end
      end

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

end
