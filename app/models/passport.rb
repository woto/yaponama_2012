# encoding: utf-8

class Passport < ActiveRecord::Base
  include BelongsToProfile
  include BelongsToCreator
  include BelongsToUser
  include Transactionable

  belongs_to :profile, :inverse_of => :passports

  validates :seriya, :nomer, :passport_vidan, :data_vidachi, :kod_podrazdeleniya, :data_rozhdeniya, :mesto_rozhdeniya, :presence => true
  validates :female, :inclusion => { :in => [true, false] }

  def to_label
    <<-CODE
    <ul>
      <li>Серия: #{seriya}</li>
      <li>Номер: #{nomer}</li>
      <li>Паспорт выдан: #{passport_vidan}</li>
      <li>Дата выдачи: #{data_vidachi}</li>
      <li>Код подразделения: #{kod_podrazdeleniya}</li>
      <li>Пол: #{female ? "Женский" : "Мужской"}</li>
      <li>Дата рождения: #{data_rozhdeniya}</li>
      <li>Место рождения: #{mesto_rozhdeniya}</li>
    </ul>
    CODE
  end
end
