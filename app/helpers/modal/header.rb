class Modal::Header < AbstractBootstrap

  def close &block
    @template.content_tag :button, '&times;'.html_safe, class: 'close', type: 'button', data: { dismiss: 'modal' }
  end

  def title
    @template.content_tag :h4, class: 'modal-title' do
      yield
    end
  end

end
