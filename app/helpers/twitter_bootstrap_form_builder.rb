class TwitterBootstrapFormBuilder < ActionView::Helpers::FormBuilder

  def alert_danger
    if @object.errors[:base].any?
      @template.content_tag :div, class: 'alert alert-danger' do
        yield
      end
    end
  end

  def text_field method, options = {}
    options[:placeholder] = I18n.t("helpers.placeholders.#{method}", default: I18n.t("helpers.placeholders.#{self.object.class.to_s.underscore}.#{method}", default: '') || options[:placeholder] || '')
    options[:class] = [ 'form-control', options[:class] ].compact
    super method, options
  end
    options[:placeholder] = I18n.t("helpers.placeholders.#{method}", default: options[:placeholder] || '')
    options[:class] = [ 'form-control', options[:class] ].compact
    super method, options
  end

  def password_field method, options = {}
    options[:class] = [ 'form-control', options[:class] ].compact
    super method, options
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

  def submit method = nil, options = {}
    options[:class] = [ 'btn btn-primary', options[:class] ].compact
    super method, options
  end

  def hint text
    @template.content_tag :span, text, class: "help-block"
  end
 

  def error method, options = {}
    method = method.to_s.chomp('_id').to_sym
    if @object.errors[method].present?
      @template.content_tag :span, class: "help-block" do
        @template.content_tag :b, @object.errors[method].join(', ')
      end
    end
  end

  def control_label method, options = {}
    options[:class] = [ 'col-lg-2 col-md-3 col-sm-3 control-label', options[:class] ].compact
    label method, options
  end

  def label method, options = {}
    options[:class] = [ 'control-label', options[:class] ].compact
    super method, options
  end

  def phone_input name, opts={}
    @template.render 'phone_input', f: self, name: name, placeholder: opts[:placeholder], rel: opts[:rel]
  end

  def text_input name, opts={}
    @template.render 'text_input', f: self, name: name, placeholder: opts[:placeholder], rel: opts[:rel]
  end

  def password_input name, opts={}
    @template.render 'password_input', f: self, name: name, placeholder: opts[:placeholder], rel: opts[:rel]
  end

  def standard_submit text=nil
    @template.render 'standard_submit', f: self, text: text
  end

  def standard_remove
    @template.link_to_remove_association '<i class="icon-trash ignoredirty"></i>'.html_safe, self, :class => "btn btn-danger pull-right ignoredirty", data: { confirm: 'Are you sure?' }
  end

  def standard_recreate
    hidden_field :hidden_recreate
  end

  def radio_buttons_inline method, collection, value_method, text_method, options = {}, html_options = {}, &block
    @template.render 'radio_buttons_inline', f: self, method: method, collection: collection, value_method: value_method, text_method: text_method, options: options, html_options: html_options, block: block
  end

  def radio_buttons_themed method, collection, value_method, text_method, options = {}, html_options = {}, &block
    @template.render 'radio_buttons_themed', f: self, method: method, collection: collection, value_method: value_method, text_method: text_method, options: options, html_options: html_options, block: block
  end

  def check_boxes_themed
    raise 'not implemented'
  end

  def radio_buttons method, collection, value_method, text_method, options = {}, html_options = {}, &block
    @template.render 'radio_buttons', f: self, method: method, collection: collection, value_method: value_method, text_method: text_method, options: options, html_options: html_options, block: block
  end

  def date_input method, options = {}, html_options = {}
    html_options[:class] = [ 'form-control datetime', html_options[:class] ].compact
    @template.render 'date_input', f: self, method: method, options: options, html_options: html_options
  end

  def select_input(method, choices, options = {}, html_options = {})
    html_options[:class] = ['form-control', html_options[:class]].compact
    @template.render 'select_input', f: self, method: method, choices: choices, options: options, html_options: html_options
  end


  def passport_date_input method
    date_input(method, start_year: Time.now.year - 100, end_year: Time.now.year, include_blank: true)
  end

  def destroyable
    if object._destroy
      @template.hidden_field_tag("#{object_name}[_destroy]", '1')
    else
      yield
    end
  end

end
