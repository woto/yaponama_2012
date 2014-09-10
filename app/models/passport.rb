# encoding: utf-8
#
class Passport < ActiveRecord::Base
  include HiddenRecreate
  include BelongsToProfile
  include BelongsToCreator
  include BelongsToSomebody
  include Transactionable
  include Selectable

  read_only :creation_reason

  belongs_to :profile, :inverse_of => :passports

  validates :gender, :seriya, :nomer, :passport_vidan, :data_vidachi, :kod_podrazdeleniya, :data_rozhdeniya, :mesto_rozhdeniya, :presence => true
  validates :gender, :inclusion => { :in => ['male', 'female'] }

  def to_label
    <<-CODE
      Серия: #{seriya}, 
      Номер: #{nomer}, 
      Паспорт выдан: #{passport_vidan}, 
      Дата выдачи: #{data_vidachi}, 
      Код подразделения: #{kod_podrazdeleniya}, 
      Пол: #{gender == 'male' ? "Мужской" : "Женский"}, 
      Дата рождения: #{data_rozhdeniya}, 
      Место рождения: #{mesto_rozhdeniya}
    CODE
  end

end
