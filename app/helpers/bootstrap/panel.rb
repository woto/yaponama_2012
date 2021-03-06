class Bootstrap::Panel < Bootstrap::Bootstrap

  def heading options={}
    options[:class] = ['panel-heading', options[:class] ].compact
    @template.content_tag :div, options do
      yield
    end
  end

  def collapse options={}
    options[:class] = ['panel-collapse collapse', options[:class] ].compact
    @template.content_tag :div, options do
      yield
    end
  end

  def title options={}
    options[:class] = ['panel-title', options[:class] ].compact
    @template.content_tag :h3, options do
      yield
    end
  end

  def body options={}
    options[:class] = ['panel-body', options[:class] ].compact
    @template.content_tag :div, options do
      yield
    end
  end

  def footer options={}
    options[:class] = ['panel-footer', options[:class] ].compact
    @template.content_tag :div, options do
      yield
    end
  end

end

