class Shipment < ActiveRecord::Base
  attr_accessible :delivery_cost, :notes_invisible, :notes
end
