# encoding: utf-8
#
class Modal < AbstractBootstrap

  def header &block
    @template.content_tag :div, class: 'modal-header' do
      yield Modal::Header.new(@template)
    end
  end

  def body
    @template.content_tag :div, class: 'modal-body' do
      yield
    end
  end

  def footer
    @template.content_tag :div, class: 'modal-footer' do
      yield Modal::Footer.new(@template)
    end
  end

end
