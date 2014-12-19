class CarsDateInput < SimpleForm::Inputs::Base
  def input(wrapper_options = nil)
    template.content_tag :div do
      @builder.date_select attribute_name, {add_month_numbers: true, discard_day: true, start_year: 1990, end_year: Date.today.year, include_blank: true}, {class: 'form-control datetime'}
    end
  end
end
