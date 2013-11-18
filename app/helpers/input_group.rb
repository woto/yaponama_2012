# encoding: utf-8
#
class InputGroup < AbstractBootstrap

  def btn
    @template.content_tag :span, class: 'input-group-btn' do
      yield
    end
  end

end
