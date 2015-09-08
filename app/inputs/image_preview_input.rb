class ImagePreviewInput < SimpleForm::Inputs::FileInput
  def input(wrapper_options = nil)
    template.capture do
      template.concat @builder.input(attribute_name)
      template.concat @builder.input("remote_#{attribute_name}_url", hint: 'Выберите файл или укажите ссылку на изображение')
      template.concat template.image_tag(object.send(attribute_name).fit_thumb) if object.send(attribute_name).present?
      template.concat @builder.input("remove_#{attribute_name}", as: :boolean)
      template.concat @builder.input("#{attribute_name}_cache", as: :hidden)
    end
  end
end
