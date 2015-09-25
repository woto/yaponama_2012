class Bootstrap::Modal::Footer < Bootstrap::Bootstrap
  #def close
  #  @template.content_tag :button, "Закрыть", class: 'btn btn-default', type: 'button', data: { dismiss: 'modal' }, 'aria-hidden' => 'true'
  #end

  def twbs_submit value=nil, options={}
    options[:class] = [ 'btn btn-primary', options[:class] ].compact
    @template.concat submit(value, options)
    @template.concat '&nbsp;&nbsp;&nbsp;или&nbsp;&nbsp;&nbsp;'.html_safe
    @template.content_tag :button, "Закрыть", class: 'btn btn-default', type: 'button', data: { dismiss: 'modal' }, 'aria-hidden' => 'true'
  end
end
