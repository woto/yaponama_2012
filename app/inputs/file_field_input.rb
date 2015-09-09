class FileFieldInput < SimpleForm::Inputs::FileInput
  def input(wrapper_options = nil)
    template.capture do
      template.panel 'default' do |p|
        p.body do
          template.concat @builder.input(attribute_name, label: false)
          template.concat @builder.input("remote_#{attribute_name}_url", label: false, hint: 'Выберите файл на компьютере или укажите ссылку')
          template.concat template.link_to(
            object.send(attribute_name).file.filename,
            object.send(attribute_name.url)) if object.send(attribute_name).present?
          template.concat @builder.input("remove_#{attribute_name}", as: :boolean)
          template.concat @builder.input("#{attribute_name}_cache", as: :hidden)
        end
      end
    end
  end
end
