class PageTemplate < ActionView::Helpers::FormBuilder
  def initialize template
    @template = template
  end

  def breadcrumb(size = :lg)
    @template.container do
      @template.row class: 'top-space bottom-space-sm' do
        @template.content_tag :div, class: css_class(size) do
          @template.content_tag(:ol, :class => 'breadcrumb') do
            yield Breadcrumb.new @template
          end
        end
      end
    end
  end

  def title(size = :lg)
    @template.container do
      @template.row class: 'top-space-sm' do
        @template.content_tag :div, class: css_class(size) do
          yield
        end
      end
    end
  end

  def content(size = :lg)
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
    when :xs
      'col-lg-8 col-md-12 col-sm-16'
    when :sm
      'col-lg-12 col-md-16 col-sm-20'
    when :md
      'col-lg-14 col-md-18 col-sm-24'
    when :lg
      'col-lg-24'
    end
  end

end
