# encoding: utf-8
#
class Modal::Footer < AbstractBootstrap
  def close
    @template.content_tag :button, "Закрыть", class: 'btn btn-default', type: 'button', data: { dismiss: 'modal' }, 'aria-hidden' => 'true'
  end
end
