module FormTransition

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

  def standard_remove
    @template.link_to_remove_association(
      @template.icon('times'),
      self,
      :style => "border-bottom: none;",
      :class => "pull-right btn btn-unstyled btn-xs",
      data: { confirm: 'Действительно хотите удалить?' }
    )
  end

  def nested_fields &block
    res = @template.capture(&block)
    @template.content_tag :div, class: "nested-fields" do
      #@template.concat block.call
      res
    end
  end

  def destroyable
    if object.marked_for_destruction?
      @template.hidden_field_tag("#{object_name}[_destroy]", '1')
    else
      yield
    end
  end
end
