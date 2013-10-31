json.array!(@admin_bbbs) do |admin_bbb|
  json.extract! admin_bbb, :name, :content
  json.url admin_bbb_url(admin_bbb, format: :json)
end
