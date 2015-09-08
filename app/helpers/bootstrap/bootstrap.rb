class Bootstrap::Bootstrap < ActionView::Helpers::FormBuilder
  def initialize template
    @template = template
  end
end

