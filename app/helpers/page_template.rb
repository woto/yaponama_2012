class PageTemplate < ActionView::Helpers::FormBuilder
  def initialize template
    @template = template
  end

  def breadcrumb
    @template.container do
      @template.row class: 'top-space bottom-space-sm' do
        @template.content_tag :div, class: 'col-lg-24' do
          yield
        end
      end
    end
  end

  def title
    @template.container do
      @template.row class: 'top-space-sm' do
        @template.content_tag :div, class: 'col-lg-24' do
          #@template.content_tag(:div, :style => 'background: #FAFAFA; padding: 15px 15px 15px 15px; box-shadow: 0 1px 3px rgba(0, 0, 0, 0.3);') do
          @template.content_tag :div do
            yield
          end
        end
      end
    end
  end

  # TODO зарефакторить. Убрать дубликат.
  def title_sm
    @template.container do
      @template.row class: 'top-space-sm' do
        @template.content_tag :div, class: 'col-lg-12 col-lg-offset-6' do
          #@template.content_tag(:div, :style => 'background: #FAFAFA; padding: 15px 15px 15px 15px; box-shadow: 0 1px 3px rgba(0, 0, 0, 0.3);') do
          @template.content_tag :div do
            yield
          end
        end
      end
    end
  end

  def content
    @template.container do
      @template.row do
        @template.content_tag :div, class: 'col-lg-24' do
          #@template.content_tag(:div, :style => 'background: white; padding: 25px 15px 15px 15px; box-shadow: 0 1px 3px rgba(0, 0, 0, 0.3);') do
          @template.content_tag :div do
            yield
          end
        end
      end
    end
  end

  # TODO зарефакторить. Убрать дубликат.
  def content_sm
    @template.container do
      @template.row do
        @template.content_tag :div, class: 'col-lg-12 col-lg-offset-6' do
          #@template.content_tag(:div, :style => 'background: white; padding: 25px 15px 15px 15px; box-shadow: 0 1px 3px rgba(0, 0, 0, 0.3);') do
          @template.content_tag(:div) do
            yield
          end
        end
      end
    end
  end

end
