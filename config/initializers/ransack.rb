Ransack.configure do |config|
  config.add_predicate 'characters_gt',
  arel_predicate: 'gt',
  #formatter: proc { |v| v.to_date },
  #validator: proc { |v| v.present? },
  type: :string

  %w[contained_within contained_within_or_equals contains contains_or_equals overlap].each do |p|
    config.add_predicate p, arel_predicate: p#, wants_array: true
  end
end
