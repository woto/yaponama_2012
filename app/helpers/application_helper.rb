#encoding: utf-8

module ApplicationHelper
  

  def user_tabs(&block)

    res = ''.html_safe
    workspace_class = 'span12'

    content_tag(:div, :class => 'row-fluid') do
      if @user && namespace_helper == 'admin'
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
              :link => { :controller => 'products', :action => 'index' },
              :class => '',
              :dropdown => []
            },

            { :title => 'Транзакции',  
              :catch => [ 
                { :controller => 'product_transactions' }, { :controller => 'account_transactions' } ],
              :link => '#', 
              :class => 'dropdown',
              :dropdown => [
                { :title => 'Товар',  
                  :catch => [ { :controller => 'product_transactions' } ],
                  :link => { :controller => 'product_transactions', :action => 'index' },
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
