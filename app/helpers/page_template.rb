class PageTemplate < ActionView::Helpers::FormBuilder
  def initialize template
    @template = template
  end

  def breadcrumb(size = nil)
    @template.container do
      @template.row class: 'top-space bottom-space-sm' do
        @template.content_tag :div, class: css_class(size) do
          @template.content_tag(:ol, :class => 'breadcrumb') do
            yield Bootstrap::Breadcrumb.new @template
          end
        end
      end
    end
  end

  def title(size = nil)
    @template.container do
      @template.row class: 'top-space-sm' do
        @template.content_tag :div, class: css_class(size) do
          yield
        end
      end
    end
  end

  def content(size = nil)
    @template.container do
      @template.row do
        @template.content_tag :div, class: css_class(size) do
          yield
        end
      end
    end
  end

  private

  def css_class(size)
    case size
    when :auth
      'col-lg-offset-7 col-lg-10 col-md-offset-7 col-md-10 col-sm-offset-4 col-sm-16'
    when :xs
      'col-lg-14 col-md-16 col-sm-17'
    when :sm
      'col-lg-16 col-md-18 col-sm-19'
    when :md
      'col-lg-18 col-md-20 col-sm-21'
    when :lg
      'col-lg-20 col-md-24 col-sm-24'
    else
      'col-lg-24'
    end
  end

end
