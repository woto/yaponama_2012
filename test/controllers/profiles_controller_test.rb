# encoding: utf-8

require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  #setup do
  #  @profile = profiles(:first_profile)
  #end

  test 'Если покупатель хочет добавить новый профиль, то на странице нового профиля должны быть сразу добавлены для ввода имя и телефон.' do
    get 'new', { user_id: 1, resource_class: 'Profile' }
    assert_select '#profile_names_attributes_0_name'
    assert_select '#profile_phones_attributes_0_value'
    assert_select '#profile_passports_attributes_0_passport', false
    assert_select '#profile_emails_attributes_0_value', false
  end

  test 'Если покупатель добавляет новый профиль, то кнопка удаления телефона должна отсутствовать' do
    get 'new', { user_id: 1, resource_class: 'Profile' }
    assert_select '#profile_phones_attributes_0__destroy', false
  end

  test 'А вот при редактировании удалить первый номер телефона уже можно (т.е. например был добавлено два, а первый больше не рабочий. Иначе пришлось бы копировать второй телефон, его удалять и вставлять в первый)' do
    @profile = profiles(:first_admin)
    get 'edit', { user_id: @profile.somebody.id, resource_class: 'Profile', id: @profile.id }
    assert_select '#profile_phones_attributes_0__destroy'
  end

  test 'При удалении профиля так же необходимо сбрасывать кешированную версию в somebody' do
    skip
  end

end
