class Request < ActiveRecord::Base
  include PingCallback
  belongs_to :email, :inverse_of => :requests
  belongs_to :user, :inverse_of => :requests
  belongs_to :car, :inverse_of => :requests
  has_many :requests, :inverse_of => :request, :dependent => :destroy
  belongs_to :request, :inverse_of => :requests
  attr_accessible :catalog_number, :notes_invisible, :manufacturer, :notes, :creation_reason, :check_needed, :user_id, :car_id, :request_id, :requests_attributes, :name, :visible
  accepts_nested_attributes_for :requests, :allow_destroy => true

  def to_label
    "#{catalog_number} - #{manufacturer} - #{notes} - #{notes_invisible}"
  end

  before_save :set_relational_attributes
  
  def set_relational_attributes
    if self.car.present?
      self.user = self.car.user
      self.requests.each do |request|
        request.car = self.car
        request.user = self.car.user
      end
    end
    if self.user.present?
      self.requests.each do |request|
        request.user = self.user
      end
    end
  end




end
