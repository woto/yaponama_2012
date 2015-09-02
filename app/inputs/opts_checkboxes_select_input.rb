class OptsCheckboxesSelectInput < SimpleForm::Inputs::CollectionSelectInput
  def options
    super.tap do |options|
      options[:collection] = Rails.configuration.send("opts_#{@builder.object.class.name.demodulize.underscore}")["#{@builder.object.class.name.demodulize.underscore}_#{attribute_name}"]['checkboxes'].map{|arr| [arr[:label], arr[:value]]}
    end
  end
end
