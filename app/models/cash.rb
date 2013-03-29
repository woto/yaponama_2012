class Cash
  include ActiveModel::Model
  attr_accessor :debit, :notes_invisible
  validates :debit, :presence => true, :numericality => true
end
