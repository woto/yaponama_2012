json.array!(@tests) do |test|
  json.extract! test, :binary, :boolean, :date, :datetime, :decimal, :float, :integer, :string, :text, :time, :timestamp
  json.url test_url(test, format: :json)
end
