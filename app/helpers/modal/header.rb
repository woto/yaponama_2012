class Modal::Header < AbstractBootstrap

  def close &block
    @template.content_tag :button, '×', class: 'close', type: 'button', data: { dismiss: 'modal' }, 'aria-hidden' => 'true'
  end

  def title
    @template.content_tag :h4, class: 'modal-title' do
      yield
    end
  end

end
