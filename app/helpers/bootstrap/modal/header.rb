class Bootstrap::Modal::Header < Bootstrap::Bootstrap

  def close &block
    @template.content_tag :button, '×', class: 'close', type: 'button', data: { dismiss: 'modal' }
  end

  def title
    @template.content_tag :h4, class: 'modal-title' do
      yield
    end
  end

end
