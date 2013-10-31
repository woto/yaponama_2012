json.array!(@letters) do |letter|
  json.extract! letter, 
  json.url letter_url(letter, format: :json)
end
