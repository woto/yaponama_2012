# Используется для отображения текстового значения (без возможности изменения) и его передачи, на странице оформления заказа
class StaticInput < SimpleForm::Inputs::StringInput
  def input(wrapper_options = nil)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    value = merged_input_options[:value].presence || object.send(attribute_name)
    template.capture do
      template.concat content_tag :p, value, class: "form-control-static"
      template.concat @builder.hidden_field(attribute_name, merged_input_options)
    end
  end
end
