module Admin::OrdersHelper

  def tab_links(id, h, &block)

    hint = ''

    workaround = Proc.new do 
      content_tag(:ul, :id => id, :class => 'nav nav-tabs') do
        h.collect do |k, v|
          if current_page?(:status => k, :page => params[:page]) || 
            ((k == 'all') && (params[:status] == 'all' || params[:status].blank? ))
            css_class = "active"  
            hint = v['hint']
          end
          concat(content_tag(:li, link_to(v['title'], url_for(:status => k)), :class => css_class))
        end
      end
    end

    concat(capture(&workaround))
    concat(capture(hint, &block))

  end
 
end
