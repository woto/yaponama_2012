# Используется для отображения названия магазина (без возможности изменения) и передачи его id, на странице оформления заказа в магазин
class StaticReferenceInput < SimpleForm::Inputs::StringInput
  def input(wrapper_options = nil)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    value = merged_input_options[:value].presence || object.send(attribute_name.to_s.chomp('_id')).to_label
    template.capture do
      template.concat content_tag :p, value, class: "form-control-static"
      template.concat @builder.hidden_field(attribute_name, merged_input_options)
    end
  end
end
