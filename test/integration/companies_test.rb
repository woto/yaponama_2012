# encoding: utf-8
#
require 'test_helper'

class CompaniesTest < ActionDispatch::IntegrationTest
  fixtures :postal_addresses, :companies

  def setup
    Capybara.reset!
  end

  def submit
    find('#new_company').find('input[type=submit]').click
  end

  test "Адресов нет | => | проверяем первичное состояние формы для ввода компании." do
    auth('+5 (555) 555-55-55', '5555555555')
    visit '/user/companies/new'

    # Есть поле для ввода наименования организации
    assert page.has_css? "#company_name"

    # Есть поле для ввода индекса юр. адреса
    assert page.has_css? '#company_new_legal_address_attributes_postcode', :visible => true

    # Есть поле для выбора факт. адреса
    assert page.has_css? '#company_old_actual_address_id'
  end

  test "Адресов нет | Наимен. орг. - не заполнили | юр. адрес - не заполнили индекс | факт. - не выбрали" do
    auth('+5 (555) 555-55-55', '5555555555')
    visit '/user/companies/new'

    # Отправляем форму
    submit

    # Есть ошибка в наименовании организации
    assert page.has_css? "#company_name ~ span b", text: 'не может быть пустым'

    # Есть ошибка в индексе юр. адреса
    assert page.has_css? "#company_new_legal_address_attributes_postcode ~ span", text: 'не может быть пустым'

    # Есть ошибка в списке выбора факт. адреса
    assert page.has_css? "#company_old_actual_address_id ~ span", text: 'не может быть пустым'
  end

  test "Адресов нет | юр. - ничего не выбрали | факт. - не заполнили поля | => | Ошибка у обоих" do
    auth('+5 (555) 555-55-55', '5555555555')
    visit '/user/companies/new'

    # Щелкаем на ссылке для появления юр. адреса из списка
    find('#company_legal_address_type_old', visible: false).find(:xpath,".//..").click

    # Щелкаем на ссылке для появления полей для ввода нового факт. адреса
    find('#company_actual_address_type_new', visible: false).find(:xpath,".//..").click
    
    # Отправляем форму
    submit

    # Проверяем наличие ошибки у поля для выбора юр. адреса
    assert page.has_css?('#company_old_legal_address_id ~ span', text: 'не может быть пустым')

    # Проверяем наличие ошибки у поля для ввода индекса факт. адреса
    assert page.has_css?('#company_new_actual_address_attributes_postcode ~ span b', text: 'не может быть пустым')
  end

  test "Адресов нет | юр. и факт. - список, но ничего не выбрали | => | Ошибка у обоих" do
    auth('+5 (555) 555-55-55', '5555555555')
    visit '/user/companies/new'

    # Щелкаем на ссылке для появления юр. адреса из списка
    find('#company_legal_address_type_old', visible: false).find(:xpath,".//..").click

    # Отправляем форму
    submit

    # Проверяем наличие ошибки у поля для выбора юр. адреса
    assert page.has_css?('#company_old_legal_address_id ~ span', text: 'не может быть пустым, имеет непредусмотренное значение')

    # Проверяем наличие ошибки у поля для выбора факт. адреса
    assert page.has_css?('#company_old_actual_address_id ~ span', text: 'не может быть пустым, имеет непредусмотренное значение')
  end

  test "Адресов нет | юр и факт - в обоих сослались на противоположный | => | Ошибка у обоих" do
    auth('+5 (555) 555-55-55', '5555555555')
    visit '/user/companies/new'

    # Щелкаем на ссылке для появления юр. адреса из списка
    find('#company_legal_address_type_old', visible: false).find(:xpath,".//..").click

    # Факт. выбрали 'Такой же как и юр.'
    find('#company_old_actual_address_id').find("option[value='-1']").select_option

    # Юр. выбрали 'Такой же как и факт.'
    find('#company_old_legal_address_id').find("option[value='-1']").select_option

    # Отправляем форму
    submit 

    # Проверяем наличие ошибки у поля для выбора юр. адреса
    assert page.has_css?('#company_old_legal_address_id ~ span', text: 'не может быть пустым')

    # Проверяем наличие ошибки у поля для выбора факт. адреса
    assert page.has_css?('#company_old_actual_address_id ~ span', text: 'не может быть пустым')
  end

  test "Адресов нет | юр. - не заполн. индекс | факт - такой же как и юр. | => | ошибка у юр. | факт. ошибку не отображаем" do
    auth('+5 (555) 555-55-55', '5555555555')
    visit '/user/companies/new'

    # Факт. выбрали 'Такой же как и юр.'
    find('#company_old_actual_address_id').find('option[value="-1"]').select_option

    submit

    # Есть ошибка в индексе юр. адреса
    assert page.has_css? "#company_new_legal_address_attributes_postcode ~ span", text: 'не может быть пустым'

    # Нет ошибки в факт. адресе
    assert page.has_no_css? "#company_old_actual_address_id ~ span", text: 'не может быть пустым, имеет непредусмотренное значение'

  end

  test "Рекв. компании - валидны | юр. адрес - валиден | факт. - валиден | => | Новая компания и адрес" do
    auth('+5 (555) 555-55-55', '5555555555')
    visit '/user/companies/new'
    c1 = Company.count

    # Организационно правовая форма
    find("#company_ownership_individual").set(true)

    # Наименование организации 
    find("#company_name").set('Рога и копыта')

    # ИНН
    find("#company_inn").set('1234567890')

    # Индекс
    find("#company_new_legal_address_attributes_postcode").set('123456')

    # Регион
    find("#company_new_legal_address_attributes_region").set('Регион')

    # Город
    find("#company_new_legal_address_attributes_city").set('Город')

    # Улица
    find("#company_new_legal_address_attributes_street").set('Улица')

    # Дом
    find("#company_new_legal_address_attributes_house").set('Дом')

    # Квартира
    find("#company_new_legal_address_attributes_room").set('Квартира')

    # Факт. адрес такой же как и юрид.
    find('#company_old_actual_address_id').find("option[value='-1']").select_option

    submit
    sleep 2

    c2 = Company.count

    assert_not_equal c1, c2

    #assert page.has_css? '.alert-success', text: "Company был успешно создан."

  end

  test "Адрес есть | => | проверяем первичное состояние формы для ввода компании." do
    auth('+7 (123) 123-12-31', '1231231231')
    visit '/user/companies/new'

    # Есть поле для ввода наименования организации
    assert page.has_css? "#company_name"

    # Есть поле для выбора юр. адреса
    assert page.has_css? '#company_old_legal_address_id'

    # Есть поле для выбора факт. адреса
    assert page.has_css? '#company_old_actual_address_id'
  end 

  test "Адрес есть | факт. - имеющийся | юр. - такой же как и юр | => | валидация адресов пройдена" do
    auth('+7 (123) 123-12-31', '1231231231')
    visit '/user/companies/new'

    c1 = Company.count

    # Организационно правовая форма
    choose "company_ownership_individual"

    # Наименование организации 
    find("#company_name").set('Рога и копыта')

    # ИНН
    find("#company_inn").set('1234567890')

    # Юр. выбрали "Такой же как и физ."
    find('#company_old_legal_address_id').find("option[value='#{postal_addresses(:first_user).id}']").select_option

    # Факт. выбрали имеющийся
    find('#company_old_actual_address_id').find("option[value='-1']").select_option

    submit
    sleep 2

    c2 = Company.count

    assert_not_equal c1, c2

    #assert page.has_css? '.alert-success', text: "Company был успешно создан."

  end
  
  test "Редактирование компании - юр. и факт. адреса в виде выбора эл-ов списка" do
    auth('+7 (123) 123-12-31', '1231231231')
    company_id = companies(:first_user)
    visit edit_user_company_path(company_id)

    # Есть поле для выбора факт. адреса
    assert page.has_css? '#company_old_actual_address_id'

    # Есть поле для выбора юр. адреса
    assert page.has_css? '#company_old_legal_address_id'
  end


end
