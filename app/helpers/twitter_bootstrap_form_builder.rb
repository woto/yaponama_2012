class TwitterBootstrapFormBuilder < ActionView::Helpers::FormBuilder

  def alert_danger
    # TODO Проработать этот вопрос. base есть не всегда. Желательно выкидывать в самый верх, но тоже не во всех случая - для вложенных форм это будет криво.
    if @object.errors[:base].any?
      @template.content_tag :div, class: 'alert alert-danger' do
        yield
      end
    end
  end

  def form_group method = nil, options = {}, &block
    # TODO скопировано с формы компании. Т.к. там подстраивался под simple_form
    # то может быть будет полезно соблюдать его правила и так же добавить такой класс
    # company_#{item[:assoc]}
    options[:class] = [ 'form-group', options[:class] ].compact
    options[:class] = [ 'has-error', options[:class] ].compact if method && @object.errors[method].any?
    @template.content_tag :div, options do
      yield
    end
  end

  def destroyable
    if object.marked_for_destruction?
      @template.hidden_field_tag("#{object_name}[_destroy]", '1')
    else
      yield
    end
  end

  def error method, options = {}
    method = method.to_s.chomp('_id').to_sym
    if @object.errors[method].present?
      @template.content_tag :span, class: "help-block" do
        @template.content_tag :b, @object.errors[method].join(', ')
      end
    end
  end

  def standard_remove
    @template.link_to_remove_association '<i class="icon-trash ignoredirty"></i>'.html_safe, 
      self, 
      :class => "btn pull-right ignoredirty btn-unstyled",
      data: { confirm: 'Действительно хотите удалить?' }
  end

  def standard_recreate
    hidden_field :hidden_recreate
  end

  def hint symbol_or_hint
    if symbol_or_hint.is_a? Symbol
      symbol_or_hint = symbol_or_hint.to_s.chomp('_id').to_sym
      hint = I18n.t("#{self.object.class.to_s.underscore}.#{symbol_or_hint}", default: [symbol_or_hint, ''], scope: [:helpers, :hints])
    else
      hint = symbol_or_hint
    end
    @template.content_tag(:span, hint, class: "help-block") if hint.present?
  end

  def control_label method, options = {}
    options[:class] = ['col-lg-2 col-md-3 col-sm-3 control-label', options[:class]].compact
    requireable_label method, options
  end

  def requireable_label method, options = {}
    asterisk = options.delete(:asterisk)
    options[:class] = [asterisk ? 'required' : nil, options[:class]].compact
    label(method, options)
  end

  def phone method, options={}
    extra = common_options method, options
    @template.render 'phone', f: self, method: method, extra: extra
  end

  def select2 method, options={}
    extra = common_options method, options
    @template.render 'select2', f: self, method: method, options: options, extra: extra
  end

  def twbs_submit value=nil, options={}
    options[:class] = [ 'btn btn-primary', options[:class] ].compact
    @template.render 'twbs_submit', f: self, value: value, options: options
  end

  def twbs_text_field method, options = {}
    extra = common_options method, options
    classify options
    @template.render 'twbs_text_field', f: self, method: method, options: options, extra: extra
  end

  def twbs_text_area method, options={}
    extra = common_options method, options
    classify options
    @template.render 'twbs_text_area', f: self, method: method, options: options, extra: extra
  end

  def twbs_password_field method, options={}
    extra = common_options method, options
    classify options
    @template.render 'twbs_password_field', f: self, method: method, options: options, extra: extra
  end

  def twbs_collection_radio_buttons method, collection, value_method, text_method, options = {}, html_options = {}, &block
    raise 'Unable to use with block' if block
    extra = common_options method, options
    variation = options.delete(:variation).to_s
    raise 'wrong variation type [themed|inline|vertical]' unless ['themed', 'inline', 'vertical'].include? variation 
    @template.render "twbs_collection_radio_buttons_#{variation}", f: self, method: method, collection: collection, value_method: value_method, text_method: text_method, options: options, html_options: html_options, block: block, extra: extra
  end

  def twbs_check_box(method, options = {}, checked_value = '1', unchecked_value = '0')
    extra = common_options method, options
    @template.render 'twbs_check_box', f: self, method: method, options: options, checked_value: checked_value, unchecked_value: unchecked_value, extra: extra
  end

  def check_box_themed(method, options = {}, checked_value = "1", unchecked_value = "0")
    # Пересмотреть TODO
    # проблема с rel
    raise 'not implemented'
  end

  def twbs_date_select_passport method, options = {}, html_options = {}
    twbs_date_select(method, options.merge(start_year: Time.now.year - 100, end_year: Time.now.year, include_blank: true), html_options)
  end

  def twbs_date_select method, options = {}, html_options = {}
    extra = common_options method, options
    classify html_options
    html_options[:class] = ['datetime', html_options[:class] ].compact
    @template.render 'twbs_date_select', f: self, method: method, options: options, html_options: html_options, extra: extra
  end

  def twbs_select(method, choices, options = {}, html_options = {})
    extra = common_options method, options
    classify html_options
    @template.render 'twbs_select', f: self, method: method, choices: choices, options: options, html_options: html_options, extra: extra
  end

  private
  
  def common_options method, options
    options[:placeholder] = I18n.t("helpers.placeholders.#{method}", default: [I18n.t("helpers.placeholders.#{self.object.class.to_s.underscore}.#{method}", default: [options[:placeholder], ''])])
    extra = {}
    extra[:label] = options.delete(:label)
    extra[:asterisk] = options.delete(:asterisk)
    extra

  end

  def classify options
    options[:class] = [ 'form-control', options[:class] ].compact
  end

end
