# encoding: utf-8
#
class Panel < AbstractBootstrap

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

  def body
    @template.content_tag :div, class: 'panel-body' do
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

