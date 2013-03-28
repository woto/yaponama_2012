class Cash
  include ActiveModel::Model
  attr_accessor :value
  validates :value, :numericality => true
end
