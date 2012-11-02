class Delivery < ActiveRecord::Base
  attr_accessible :available, :name, :notes, :prepayment, :invisible
end
