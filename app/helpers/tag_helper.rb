# encoding: utf-8
#
module TagHelper

  def control_label method, options = {}
    # TODO переработать, во-первых дублируется, во вторых for коряво
    options[:class] = ['control-label', options[:class]].compact
    label '', method, options
  end

  def twbs_text_field_tag name, value = nil, options = {}
    options[:class] = [ 'form-control', options[:class] ].compact
    text_field_tag name, value, options
  end

  def twbs_radio_button_tag name, value, checked = false, options = {}, &block
    content_tag :div, class: 'radio' do
      content_tag :label do
        res = capture(&block)
        radio_button_tag(name, value, checked, options) + res
      end
    end
  end

  def twbs_select_tag name, option_tags = nil, options = {}
    options[:class] = [ 'form-control', options[:class] ].compact
    select_tag name, option_tags, options
  end

  def twbs_date_field_tag name, value = nil, options = {}
    options[:class] = [ 'form-control', options[:class] ].compact
    options[:class] = ['datetime', options[:class] ].compact
    date_field_tag name, value, options
  end

  def form_group method = nil, options = {}, &block
    options[:class] = [ 'form-group', options[:class] ].compact
    content_tag :div, options do
      yield
    end
  end

  def twbs_button_tag(content_or_options = nil, options = nil, &block)

    if block_given? && content_or_options.is_a?(Hash)
      content_or_options = content_or_options.stringify_keys
      content_or_options['class'] = ['btn', content_or_options['class']].compact
    else
      options = options.stringify_keys
      options['class'] = ['btn', options['class']].compact
    end

    button_tag content_or_options, options, &block
  end

end
