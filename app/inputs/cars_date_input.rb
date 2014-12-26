class CarsDateInput < SimpleForm::Inputs::DateTimeInput
  def options
    @input_type = :date
    super.tap do |options|
      options[:add_month_numbers] = true
      options[:discard_day] = true
      options[:start_year] = 1990
      options[:end_year] = Date.today.year
      options[:include_blank] = true
    end
  end
end
