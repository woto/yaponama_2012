# encoding: utf-8

require 'test_helper'

class ProfileablesControllerTest < ActionController::TestCase
  #setup do
  #  @profile = profiles(:first_profile)
  #end


  PROFILE_ATTRIBUTES = {
    'profile' => {
      'names_attributes' => {
        '0' => { 
          'name' => '1'
        }
      },
      'phones_attributes' => {
        '0' => {
          'phone' => '1',
          'phone_type' => 'unknown'
        }
      },
      'email_addresses_attributes' => {
        '0' => {
          'email_address' => 'a@a.ru'
        }
      },
      'passports_attributes' => {
        '0' => {
          'data_rozhdeniya(1i)' => '2013',
          'data_rozhdeniya(2i)' => '5',
          'data_rozhdeniya(3i)' => '18',
          'data_vidachi(1i)' => '2013',
          'data_vidachi(2i)' => '5',
          'data_vidachi(3i)' => '18',
          'female' => 'false',
          'kod_podrazdeleniya' => '1',
          'mesto_rozhdeniya' => '1',
          'nomer' => '1',
          'passport_vidan' => '1',
          'seriya' => '1'
        }
      }
    }
  }

  test 'Если покупатель хочет добавить новый профиль пользователю, то на странице нового профиля должны быть сразу добавлены для ввода имя и телефон.' do
    get 'new', { user_id: 1, resource_class: 'Profile' }
    assert_select '#profile_names_attributes_0_name'
    assert_select '#profile_phones_attributes_0_phone'
    assert_select '#profile_passports_attributes_0_passport', false
    assert_select '#profile_email_addresses_attributes_0_email_address', false
  end

  test 'Если покупатель добавляет новый профиль, то кнопка удаления телефона должна отсутствовать' do
    get 'new', { user_id: 1, resource_class: 'Profile' }
    assert_select '#profile_phones_attributes_0__destroy', false
  end

  test 'А вот при редактировании удалить первый номер телефона уже можно (т.е. например был добавлено два, а первый больше не рабочий. Иначе пришлось бы копировать второй телефон, его удалять и вставлять в первый)' do
    @profile = profiles(:first_profile)
    get 'edit', { user_id: @profile.user.id, resource_class: 'Profile', id: @profile.id }
    assert_select '#profile_phones_attributes_0__destroy'
  end

  test 'Если покупатель создает новый профиль, то creation_reason полей должен быть profile' do
    post 'create', { user_id: 1, resource_class: 'Profile'}.merge(PROFILE_ATTRIBUTES)

    assert assigns(:resource).creation_reason == 'profile'
    assert assigns(:resource).phones.first.creation_reason == 'profile'
    assert assigns(:resource).names.first.creation_reason == 'profile'
    assert assigns(:resource).email_addresses.first.creation_reason == 'profile'
    assert assigns(:resource).passports.first.creation_reason == 'profile'

  end

end
