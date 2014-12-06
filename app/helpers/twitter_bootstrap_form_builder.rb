# encoding: utf-8
#
class TwitterBootstrapFormBuilder < ActionView::Helpers::FormBuilder

  def alert_danger
    # TODO Проработать этот вопрос. base есть не всегда. Желательно выкидывать в самый верх, но тоже не во всех случая - для вложенных форм это будет криво.
    if @object.errors[:base].any?
      @template.alert 'danger' do
      # TODO Проверить
      #@template.content_tag :div, class: 'alert alert-danger' do
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
      options[:class] = ['help-block', options[:class]].compact
      @template.content_tag :span, options do
        @template.content_tag :b, @object.errors[method].uniq.join(', ')
      end
    end
  end

  def standard_remove
    @template.link_to_remove_association( 
      @template.icon('times'),
      self, 
      :style => "border-bottom: none;",
      :class => "pull-right btn btn-unstyled btn-xs",
      data: { confirm: 'Действительно хотите удалить?' }
    )
  end

  def standard_recreate
    #hidden_field :hidden_recreate, value: '1'
    label = label(:hidden_recreate)
    input = text_field(:hidden_recreate, value: '1')
    @template.content_tag(:div, label + @template.tag(:br) + input, style: 'margin: 5px 0; display: none')
  end

  def hint method, options
    if options[:hint] == false
      ''.html_safe
    else
      method = method.to_s.chomp('_id')
      a1 = I18n.t("#{self.object.class.to_s.underscore}.#{method}", default: '', scope: [:helpers, :hints])
      a2 = I18n.t("#{method}", default: '', scope: [:helpers, :hints])
      a3 = options[:hint]
      str = a1.presence || a2.presence || a3.presence
      if str
        @template.hint do
          str
        end
      end
    end
  end

  def control_label method, options = {}
    #options[:class] = ['col-lg-2 col-md-3 col-sm-3 control-label', options[:class]].compact
    #options[:class] = ['col-xs-12', options[:class]].compact
    options[:class] = ['control-label', options[:class]].compact
    requireable_label method, options
  end

  def requireable_label method, options = {}
    if options[:label] == false
      ''.html_safe
    else
      asterisk = options.delete(:asterisk)
      options[:class] = [asterisk ? 'required' : nil, options[:class]].compact
      if options[:label]
        @template.label_tag method, options[:label], options
      else
        label(method, options)
      end
    end
  end

  def phone method, options={}
    extra = common_options method, options
    @template.render 'phone', f: self, method: method, extra: extra
  end

  def twbs_submit value=nil, options={}
    options[:class] = [ 'btn btn-primary btn-lg top-space bottom-space', options[:class] ].compact
    form_group nil, class: 'bottom-space-none' do
      @template.concat submit(value, options)
      if @template.params[:return_path]
        @template.concat '&nbsp;&nbsp;&nbsp;или&nbsp;&nbsp;&nbsp;'.html_safe
        @template.concat(@template.link_to('Назад', @template.params[:return_path], :class => 'btn btn-default', :data => { :confirm => 'Уверены что хотите вернуться назад без сохранения?' }))
      end
    end
  end

  def twbs_hidden_field(method, options = {})
    hidden_field method, options
  end

  def twbs_1 method, options = {}
    extra = common_options method, options
    classify options
    form_group(method) do
      control_label(method, label: extra[:label], asterisk: extra[:asterisk]).to_s +
      yield +
      error(method).to_s +
      hint(method, hint: extra[:hint]).to_s
    end
  end

  def twbs_2 method, options = {}
    # TODO Здесь все то же самое за исключением что отсутсвует вызов classify
    extra = common_options method, options
    form_group(method) do
      control_label(method, label: extra[:label], asterisk: extra[:asterisk]).to_s +
      yield +
      error(method).to_s +
      hint(method, hint: extra[:hint]).to_s
    end
  end

  def twbs_select2 method, options={}
    twbs_2(method, options) do
      twbs_hidden_field(method, options)
    end
  end



  def twbs_file_field method, options = {}
    twbs_2(method, options) do
      file_field(method, options).to_s
    end
  end
   

  def twbs_text_field method, options = {}
    twbs_1(method, options) do
      text_field(method, options).to_s
    end
  end

  def twbs_text_area method, options={}
    twbs_1(method, options) do
      text_area(method, options).to_s
    end
  end


  def twbs_password_field method, options={}
    twbs_1(method, options) do
      password_field(method, options).to_s
    end
  end


  def nested_fields &block
    res = @template.capture(&block)
    @template.content_tag :div, class: "nested-fields" do
      #@template.concat block.call
      res
    end
  end

  def error_notification
    if @object.errors.any?
      @template.alert 'warning' do
        [
          "<strong>Форма заполнена не корретно, пожалуйста исправьте ошибки.</strong><br />",
          @template.content_tag(:ul, class:'list-unstyled') do
            collector = []
            @object.errors.full_messages.each do |msg|
              collector << (@template.content_tag :li do
                msg
              end)
            end
            collector.join.html_safe
          end
        ].join.html_safe
      end
    end
  end

  def twbs_collection_radio_buttons method, collection, value_method, text_method, options = {}, html_options = {}, &block
    raise 'Unable to use with block' if block
    extra = common_options method, options
    variation = options.delete(:variation).to_s
    raise 'wrong variation type [themed|inline|vertical]' unless ['payment', 'themed', 'inline', 'vertical'].include? variation 
    @template.render "twbs_collection_radio_buttons_#{variation}", f: self, method: method, collection: collection, value_method: value_method, text_method: text_method, options: options, html_options: html_options, block: block, extra: extra
  end

  def twbs_collection_check_boxes(method, collection, value_method, text_method, options = {}, html_options = {}, &block)
    # TODO переопределить под бутстрап
    @template.collection_check_boxes(@object_name, method, collection, value_method, text_method, objectify_options(options), @default_options.merge(html_options), &block)
  end

  def twbs_check_box(method, options = {}, checked_value = '1', unchecked_value = '0')
    extra = common_options method, options
    #@template.render 'twbs_check_box', f: self, method: method, options: options, checked_value: checked_value, unchecked_value: unchecked_value, extra: extra
    form_group(method) do
      @template.content_tag(:div, class: 'checkbox') do
        @template.content_tag :label do
          check_box(method, options, checked_value, unchecked_value) +
          # Это неправильная структура, вложенного label быть не должно, оставил для локализации
          requireable_label(method, label: extra[:label], asterisk: extra[:asterisk])
        end
      end +
      hint(method, hint: extra[:hint])
    end
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

  def twbs_datetime_select method, options = {}, html_options = {}
    extra = common_options method, options
    classify html_options
    html_options[:class] = ['datetime', html_options[:class] ].compact
    @template.render 'twbs_datetime_select', f: self, method: method, options: options, html_options: html_options, extra: extra
  end

  def twbs_collection_select(method, collection, value_method, text_method, options = {}, html_options = {})
    extra = common_options method, options
    classify html_options
    @template.render 'twbs_collection_select', f: self, method: method, collection: collection, value_method: value_method, text_method: text_method, options: options, html_options: html_options, extra: extra
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
    extra[:hint] = options.delete(:hint)
    extra[:asterisk] = options.delete(:asterisk)
    extra

  end

  def classify options
    options[:class] = [ 'form-control', options[:class] ].compact
  end

end
