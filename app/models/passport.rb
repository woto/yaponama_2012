# encoding: utf-8
#
class Passport < ActiveRecord::Base
  include HiddenRecreate
  include BelongsToProfile
  include BelongsToCreator
  include BelongsToSomebody
  include Transactionable
  include Selectable

  belongs_to :profile, :inverse_of => :passports

  validates :gender, :seriya, :nomer, :passport_vidan, :data_vidachi, :kod_podrazdeleniya, :data_rozhdeniya, :mesto_rozhdeniya, :presence => true
  validates :gender, :inclusion => { :in => ['male', 'female'] }

  def to_label
    <<-CODE
    <ul>
      <li>Серия: #{seriya}</li>
      <li>Номер: #{nomer}</li>
      <li>Паспорт выдан: #{passport_vidan}</li>
      <li>Дата выдачи: #{data_vidachi}</li>
      <li>Код подразделения: #{kod_podrazdeleniya}</li>
      <li>Пол: #{gender == 'male' ? "Мужской" : "Женский"}</li>
      <li>Дата рождения: #{data_rozhdeniya}</li>
      <li>Место рождения: #{mesto_rozhdeniya}</li>
    </ul>
    CODE
  end

  include RenameMeConcernTwo

end
