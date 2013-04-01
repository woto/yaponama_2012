class Car < ActiveRecord::Base
  include BelongsToUser
  include BelongsToCreator
  include Transactionable

  validates :vin, :uniqueness => { case_sensitive: false }, :allow_blank => true, :length => { :within => 17..17 }
  validates :frame, :uniqueness => { case_sensitive: false }, :allow_blank => true

  def to_label
    "#{vin} - #{frame} - #{car_number} - #{brand} - #{model} - #{generation} - #{modification} - #{god} - #{period} - #{dvigatel} - #{tip} - #{moschnost} - #{privod} - #{tip_kuzova} - #{kpp} - #{kod_kuzova} - #{kod_dvigatelya} - #{rinok} - #{komplektaciya} - #{dverey} - #{rul}"
  end

end
