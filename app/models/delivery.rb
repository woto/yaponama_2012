class Delivery < ActiveRecord::Base
  attr_accessible :available, :name, :notes, :prepayment, :notes_invisible
end
