module SimpleForm
  class FormBuilder
    def buttons *args, &block
      options = args.extract_options!.dup
      options[:class] = ['btn-primary btn-lg top-space bottom-space', options[:class]].compact
      args << options
      @template.capture do
        @template.concat button(:submit, *args, &block)
        if @template.params[:return_path]
          @template.concat '&nbsp;&nbsp;&nbsp;или&nbsp;&nbsp;&nbsp;'.html_safe
          @template.concat(@template.link_to('Назад', @template.params[:return_path], class: 'btn btn-default', data: { confirm: 'Уверены что хотите вернуться назад без сохранения?' }))
        end
      end
    end
  end
end
