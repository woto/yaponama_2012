class Request < ActiveRecord::Base
  include PingCallback
  belongs_to :user, :inverse_of => :requests
  belongs_to :car, :inverse_of => :requests
  has_many :requests, :inverse_of => :request, :dependent => :destroy
  belongs_to :request, :inverse_of => :requests
  attr_accessible :catalog_number, :invisible, :manufacturer, :notes, :creation_reason, :check_needed, :approx_days, :approx_cost, :user_id, :car_id, :request_id, :requests_attributes
  accepts_nested_attributes_for :requests, :allow_destroy => true

  def to_label
    "#{catalog_number} - #{manufacturer} - #{notes} - #{invisible}"
  end

end
