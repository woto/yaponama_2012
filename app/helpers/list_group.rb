# encoding: utf-8
#
class ListGroup < AbstractBootstrap

  def item method, options={}
    @template.link_to method, class: "list-group-item" do
      yield
    end
  end

end
