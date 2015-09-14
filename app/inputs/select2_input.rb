class Select2Input < SimpleForm::Inputs::Base
  def input(wrapper_options = nil)

    has_error = object.errors[attribute_name].empty? ? {} : {wrapper_html: {class: 'has-error'}}
    @builder.simple_fields_for attribute_name, object.send(attribute_name) || object.send("build_#{attribute_name}"), include_id: false do |b|
      b.input :name, has_error.merge(wrapper: :select2_wrapper) do
        template.capture do
          template.concat(b.hidden_field :name, input_html_options.deep_merge(rel: "select2-#{attribute_name}",
            data: {"true-id" => object.send("#{attribute_name}_id")}))
          #template.concat @builder.error(attribute_name)
        end
      end
    end

  end
end
