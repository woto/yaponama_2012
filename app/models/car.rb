class Car < ActiveRecord::Base
  include PingCallback

  has_many :requests, :dependent => :destroy, :inverse_of => :car
  belongs_to :user, :inverse_of => :cars
  attr_accessible :dvigatel, :frame, :god, :kod_dvigatelya, :kod_kuzova, :komplektaciya, :kpp, :marka, :model, :moschnost, :privod, :rinok, :tip, :tip_kuzova, :vin, :invisible, :user_id, :requests_attributes
  validates :user, :presence => true
  accepts_nested_attributes_for :requests

  def to_label
    "#{dvigatel} - #{frame} - #{god} - #{kod_dvigatelya} - #{kod_kuzova} - #{komplektaciya} - #{kpp} - #{marka} - #{model} - #{moschnost} - #{privod} - #{rinok} - #{tip} - #{tip_kuzova} - #{vin} - #{invisible}"
  end

end
