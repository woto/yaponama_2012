class Bootstrap::Modal < Bootstrap::Bootstrap

  def header options={}
    options[:class] = ['modal-header', options[:class] ].compact
    @template.content_tag :div, class: options[:class] do
      yield Header.new(@template)
    end
  end

  def body options={}
    options[:class] = ['modal-body', options[:class] ].compact
    @template.content_tag :div, class: options[:class] do
      yield
    end
  end

  def footer options={}
    options[:class] = ['modal-footer', options[:class] ].compact
    @template.content_tag :div, class: options[:class] do
      yield Footer.new(@template)
    end
  end

end
