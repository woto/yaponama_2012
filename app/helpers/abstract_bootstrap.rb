# encoding: utf-8
#
class AbstractBootstrap < ActionView::Helpers::FormBuilder
  def initialize template
    @template = template
  end
end

