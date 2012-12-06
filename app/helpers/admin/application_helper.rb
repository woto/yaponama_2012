module Admin::ApplicationHelper

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

          label = ''
          if v['badge'].present?
            label = content_tag(:span, v['badge'], :class => "badge badge-#{k}")
          end
          concat(content_tag(:li, link_to(v['title'].html_safe + "   " + label , url_for(:status => k)), :class => css_class))
        end
      end
    end

    concat(capture(&workaround))
    concat(capture(hint, &block))

  end
 
  #def sortable(column, title = nil)
  #  title ||= column.titleize
  #  css_class = (column == sort_column) ? "current #{sort_direction}" : nil
  #  direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
  #  link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  #end
end
