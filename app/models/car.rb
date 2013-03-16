class Car < ActiveRecord::Base
  include BelongsToUser

  validates :vin, :uniqueness => { case_sensitive: false }, :allow_blank => true, :length => { :within => 17..17 }
  validates :frame, :uniqueness => { case_sensitive: false }, :allow_blank => true

  def to_label
    "#{dvigatel} - #{frame} - #{god} - #{kod_dvigatelya} - #{kod_kuzova} - #{komplektaciya} - #{kpp} - #{marka} - #{model} - #{moschnost} - #{privod} - #{rinok} - #{tip} - #{tip_kuzova} - #{vin} - #{car_number} - #{notes} - #{notes_invisible}"
  end

  before_validation :set_relational_attributes
  
end
