json.array!(@admin_blocks) do |admin_block|
  json.extract! admin_block, :name, :content
  json.url admin_block_url(admin_block, format: :json)
end
