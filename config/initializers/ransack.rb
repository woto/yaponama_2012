Ransack.configure do |config|
  config.add_predicate 'characters_gt',
  arel_predicate: 'gt',
  #formatter: proc { |v| v.to_date },
  #validator: proc { |v| v.present? },
  type: :string
end
