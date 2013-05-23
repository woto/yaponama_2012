# encoding: utf-8

require 'test_helper'

class CompaniesTest < ActionDispatch::IntegrationTest
  fixtures :postal_addresses, :companies

  test "На странице добавления новой компании мы должны увидеть предложение добавить новую компанию, новый юрид. адрес и по-умолчанию select с выбором фактического адреса, с option 'такой же как и фактический'" do

    Capybara.reset_sessions!
    visit '/user/companies/new'

    # Есть поле для ввода наименования организации
    assert page.has_css? "#company_name"

    # Есть поле для ввода индекса юр. адреса
    assert page.has_css? '#company_legal_address_attributes_postcode', :visible => true

    # Нет поля для ввода индекса факт. адреса
    assert page.has_css? '#company_actual_address_attributes_postcode', :visible => false

  end

  test "При посте фомры по-умолчанию мы должны получить ошибку по Company, LegalAddress и ActualAddress" do

    Capybara.reset_sessions!
    visit '/user/companies/new'

    # Постим форму
    find('#new_company').find('input[type=submit]').click

    # Есть ошибка в наименовании организации
    assert page.has_css? ".company_name.error"

    # Есть ошибка в индексе юр. адреса
    assert page.has_css? ".company_legal_address_postcode.error"

    # Есть ошибка в списке выбора факт. адреса
    assert find("#actual_address").find('.old').find('.help-inline', text: "не может быть пустым")
  end

  test "Если мы не заполнили имя компании и при этом уже заполнили юр. адрес и выбрали факт. адр. то при post'e состояние должно сохраниться. " do

    Capybara.reset_sessions!
    visit '/user/companies/new'

    find("#company_ownership_individual").set(true)
    find("#company_name").set('Рога и копыта')
    find("#company_inn").set('1234567890')
    find("#company_legal_address_attributes_postcode").set('123456')
    find("#company_legal_address_attributes_region").set('Регион')
    find("#company_legal_address_attributes_city").set('Город')
    find("#company_legal_address_attributes_street").set('Улица')
    find("#company_legal_address_attributes_house").set('Дом')
    find("#company_legal_address_attributes_room").set('Квартира')

    find('#company_actual_address_id').find("option[value='-1']").click

    find('#new_company').find('input[type=submit]').click

    assert page.has_css? '.alert-success', text: "Company was successfully created."
  end


  #test "При условии, что у посетителя уже есть хотя бы один адрес. На странице добавления новой компании мы должны увидеть предложение добавить новую компанию, и предложение выбрать из списка юрид. и факт. адреса" do
  #end 

end
