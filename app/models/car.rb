class Car < ActiveRecord::Base
  include PingCallback

  has_many :requests, :dependent => :destroy, :inverse_of => :car
  belongs_to :user, :inverse_of => :cars
  attr_accessible :car_number, :notes, :dvigatel, :frame, :god, :kod_dvigatelya, :kod_kuzova, :komplektaciya, :kpp, :marka, :model, :moschnost, :privod, :rinok, :tip, :tip_kuzova, :vin, :notes_invisible, :user_id, :requests_attributes, :visible
  validates :user, :presence => true
  accepts_nested_attributes_for :requests, :allow_destroy => true

  #validates :vin, :uniqueness => true, :allow_blank => true
  #validates :frame, :uniqueness => true, :allow_blank => true

  def to_label
    "#{dvigatel} - #{frame} - #{god} - #{kod_dvigatelya} - #{kod_kuzova} - #{komplektaciya} - #{kpp} - #{marka} - #{model} - #{moschnost} - #{privod} - #{rinok} - #{tip} - #{tip_kuzova} - #{vin} - #{car_number} - #{notes} - #{notes_invisible}"
  end

end
