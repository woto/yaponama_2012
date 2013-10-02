class Panel < AbstractBootstrap

  def heading
    @template.content_tag :div, class: 'panel-heading' do
      yield
    end
  end

  def collapse options={}
    options[:class] = ['panel-collapse collapse', options[:class] ].compact
    @template.content_tag :div, options do
      yield
    end
  end

  def title
    @template.content_tag :h4, class: 'panel-title' do
      yield
    end
  end

  def body
    @template.content_tag :div, class: 'panel-body' do
      yield
    end
  end

end
