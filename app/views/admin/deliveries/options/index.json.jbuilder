json.array!(@deliveries_options) do |deliveries_option|
  json.extract! deliveries_option, :full_prepayment_required, :postal_address_required
  json.url deliveries_option_url(deliveries_option, format: :json)
end
