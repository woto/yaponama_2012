class Select2Input < SimpleForm::Inputs::FileInput
  def input(wrapper_options = nil)
    has_error = object.errors[attribute_name].empty? ? {} : {wrapper_html: {class: 'has-error'}}
    @builder.input :name, has_error.merge(label: false) do
      template.concat @builder.hidden_field :name, rel: "select2-#{attribute_name}", data: {"true-id" => object.id}
      template.concat @builder.error(attribute_name)
    end
  end
end

