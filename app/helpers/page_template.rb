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
    when :center
      'col-lg-offset-4 col-lg-16 col-md-offset-3 col-md-18 col-sm-offset-1 col-sm-22'
    when :auth
      'col-lg-offset-7 col-lg-10 col-md-offset-6 col-md-12 col-sm-offset-4 col-sm-16'
    when :xs
      'col-lg-12 col-md-14 col-sm-16'
    when :sm
      'col-lg-16 col-md-18 col-sm-20'
    when :md
      'col-lg-18 col-md-20 col-sm-22'
    when :lg
      'col-lg-20 col-md-22 col-sm-24'
    else
      'col-lg-24'
    end
  end

end
