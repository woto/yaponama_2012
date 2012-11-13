class Car < ActiveRecord::Base

  include PingCallback

  attr_accessible :requests_attributes
  has_many :requests, :dependent => :destroy
  accepts_nested_attributes_for :requests, :allow_destroy => true

  attr_accessible :root_requests_with_car_attributes
  has_many :root_requests_with_car, :dependent => :destroy,
    :conditions => ["request_id IS NULL"], :class_name => "Request"
  accepts_nested_attributes_for :root_requests_with_car, :allow_destroy => true

  belongs_to :user
  validates :user, :presence => true

  attr_accessible :car_number, :notes, :dvigatel, :frame, :god, :kod_dvigatelya, :kod_kuzova, :komplektaciya, :kpp, :marka, :model, :moschnost, :privod, :rinok, :tip, :tip_kuzova, :vin, :notes_invisible, :visible

  #validates :vin, :uniqueness => true, :allow_blank => true
  #validates :frame, :uniqueness => true, :allow_blank => true

  def to_label
    "#{dvigatel} - #{frame} - #{god} - #{kod_dvigatelya} - #{kod_kuzova} - #{komplektaciya} - #{kpp} - #{marka} - #{model} - #{moschnost} - #{privod} - #{rinok} - #{tip} - #{tip_kuzova} - #{vin} - #{car_number} - #{notes} - #{notes_invisible}"
  end

  # validates :vin, :presence => true

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
