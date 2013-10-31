json.array!(@letter_parts) do |letter_part|
  json.extract! letter_part, :letter_id, :cid, :type, :is_attachment, :filename, :charset, :body, :size
  json.url letter_part_url(letter_part, format: :json)
end
