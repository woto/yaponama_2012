class Cash
  include ActiveModel::Model
  attr_accessor :debit, :notes
  validates :debit, :presence => true, :numericality => true
end
