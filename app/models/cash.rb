#encoding: utf-8

class Cash

  include ActiveModel::Model
  attr_accessor :debit, :comment
  validates :debit, :presence => true, :numericality => true
end
