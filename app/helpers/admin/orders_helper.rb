module Admin::OrdersHelper

  def tab_links(id, h, meth, &block)

    hint = ''

    workaround = Proc.new do 
      content_tag(:ul, :id => id, :class => 'nav nav-tabs') do
        h.collect do |k, v|
          if current_page?(meth.call(:status => k))
            css_class = "active"  
            hint = v[:hint]
          end
          concat(content_tag(:li, link_to(v[:title], meth.call(:status => k)), :class => css_class))
        end
      end
    end

    concat(capture(&workaround))
    concat(capture(hint, &block))

  end
 
end
