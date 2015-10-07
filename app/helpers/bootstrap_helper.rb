module BootstrapHelper
  def panel type, options={}, &block
    options[:class] = ["panel panel-#{type}", options[:class] ].compact
    content_tag :div, options do
      yield Bootstrap::Panel.new(self)
    end
  end

  def modal options={}, &block
    options[:class] = [ 'modal', options[:class] ].compact
    # К сожалению если раскомментировать, то select2 перестанет работать
    options[:tabindex] = "-1"
    content_tag :div, options do
      content_tag :div, class: "modal-dialog" do
        content_tag :div, class: "modal-content" do
          yield Bootstrap::Modal.new(self)
        end
      end
    end
  end

  def dropdown options={}, &block
    options[:class] = ['dropdown', options[:class] ].compact
    content_tag :li, options do
      yield Bootstrap::Dropdown.new(self)
    end
  end

  def alert type, options={}, &block

    options[:class] = ["alert alert-#{type} fade in", options[:class] ].compact

    content_tag :div, options do

      a = capture do
        content_tag(:button, :type=>"button", :class=>"close", :data=>{:dismiss=>"alert"}, :"aria-hidden"=>"true") { "×" }
      end

      b = capture do
        #block.call
        yield
      end

      a.to_s.html_safe + b.to_s.html_safe
    end

  end

  def alert_link_to name = nil, options = nil, html_options = nil, &block
    html_options ||= {}
    html_options[:class] = ['alert-link', html_options[:class] ].compact
    link_to(name, options, html_options, &block)
  end

end
