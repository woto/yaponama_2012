json.array!(@calls) do |call|
  json.extract! call, :phone_id, :file
  json.url call_url(call, format: :json)
end