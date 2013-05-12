json.array!(@delivery_zones) do |delivery_zone|
  json.extract! delivery_zone, :name
  json.url delivery_zone_url(delivery_zone, format: :json)
end