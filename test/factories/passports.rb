# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :passport do
    seriya "MyString"
    nomer "MyString"
    kem_vidan "MyString"
    data_vidachi "2013-05-02"
    kod_podrazdeleniya "MyString"
    pol false
    data_rozhdeniya "2013-05-02"
    mesto_rozhdeniya "MyString"
  end
end
