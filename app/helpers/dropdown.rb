# encoding: utf-8
#
class Dropdown < AbstractBootstrap

  def toggle options={}
    options[:class] = ['dropdown-toggle', options[:class] ].compact
    @template.link_to "#", {data: { toggle: "dropdown" }}.merge(options) do
      yield
    end
  end

  def menu
    @template.content_tag :ul, class: "dropdown-menu" do
      yield
    end
  end

  def submenu options={}
    options[:class] = ['dropdown dropdown-submenu', options[:class] ].compact
    @template.content_tag :li, options do
      yield
    end
  end

end
