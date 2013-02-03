class Car < ActiveRecord::Base
  include BelongsToUser
  include BelongsToCreator

  has_many :requests, :dependent => :destroy
  accepts_nested_attributes_for :requests, :allow_destroy => true

  has_many :root_requests_with_car, -> { where("request_id IS NULL") }, :class_name => "Request", :dependent => :destroy
  accepts_nested_attributes_for :root_requests_with_car, :allow_destroy => true

  validates :vin, :uniqueness => { case_sensitive: false }, :allow_blank => true, :length => { :within => 17..17 }
  validates :frame, :uniqueness => { case_sensitive: false }, :allow_blank => true

  def to_label
    "#{dvigatel} - #{frame} - #{god} - #{kod_dvigatelya} - #{kod_kuzova} - #{komplektaciya} - #{kpp} - #{marka} - #{model} - #{moschnost} - #{privod} - #{rinok} - #{tip} - #{tip_kuzova} - #{vin} - #{car_number} - #{notes} - #{notes_invisible}"
  end

  before_validation :set_relational_attributes
  
  def set_relational_attributes

    if self.root_requests_with_car.present?
      self.root_requests_with_car.each do |request|
        request.user = self.user
      end
    end

    if self.requests.present?
      self.requests.each do |request|
        request.user = self.user
      end
    end

  end

end
