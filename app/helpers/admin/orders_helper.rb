module Admin::OrdersHelper

  def tab_links(id, h)

    content_tag(:ul, :id => id, :class => 'nav nav-tabs') do
      h.collect do |k, v|
        css_class = "active" if current_page?(admin_orders_path(:status => k))
        concat(content_tag(:li, link_to(v, admin_orders_path(:status => k)), :class => css_class))
      end
    end
  end
 
end
