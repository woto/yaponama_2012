class OptsCheckboxesSelectInput < SimpleForm::Inputs::CollectionSelectInput
  def options
    super.tap do |options|
      options[:collection] = Rails.application.config_for("application/opts/#{@builder.object.class.name.demodulize.underscore}")["#{@builder.object.class.name.demodulize.underscore}_#{attribute_name}"]['checkboxes'].map{|arr| [arr[:label], arr[:value]]}
    end
  end
end
