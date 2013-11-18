# encoding: utf-8
#
class Dropdown < AbstractBootstrap

  def toggle
    @template.link_to "#", class: "dropdown-toggle ignoredirty", data: { toggle: "dropdown" } do
      yield
    end
  end

  def menu
    @template.content_tag :ul, class: "dropdown-menu" do
      yield
    end
  end

  def submenu
    @template.content_tag :li, class: "dropdown-submenu" do
      yield
    end
  end

end
