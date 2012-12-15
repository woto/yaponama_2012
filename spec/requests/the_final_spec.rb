# encoding: utf-8

require 'spec_helper'

describe "TestControllers", :js => true do
  describe "GET /test_controllers", :js => true do
    it "works! (now write some real specs)", :js => true do
      10.times do |k|

        full_filled_user = FactoryGirl.create(:full_filled_user)

        visit admin_user_products_path(full_filled_user)

        10.times do |i|
          checkbox = all(:css, "table input[type=checkbox]")[i].native.attribute('id')
          check checkbox
        end

        click_link "next_page"

        2.times do |i|
          checkbox = all(:css, "table input[type=checkbox]")[i].native.attribute('id')
          check checkbox
        end

        # СФОРМИРОВАНО
        first(:css, ".btn.btn-primary.dropdown-toggle").click
        #find(:css, ".dropdown-menu>li[2]>a")
        click_link 'form_inorder_action'

        page.wait_until do
          page.has_content? 'Выберите'
        end

        select('Новый заказ', :from => 'new_order_id')
        click_button 'Далее'

        page.wait_until do
          page.has_content? 'Способ доставки'
        end

        case rand(0..1)
        when 0
          select('Доставка по Москве -> Доставка до любой станции метро', :from => 'order_delivery_id')
          select('Динамо', :from => 'order_metro_id')
        when 1
          select('Почта России -> Предоплата за доставку', :from => 'order_delivery_id')
        end

        click_button 'Создать'

        # ОПЛАЧЕНО
        2.times do |i|
          checkbox = all(:css, "table input[type=checkbox]")[i].native.attribute('id')
          uncheck checkbox
        end

        first(:css, ".btn.btn-primary.dropdown-toggle").click
        click_link 'form_ordered_action'

        wait_until do
          has_content? 'Смена статуса'
        end

        click_button 'Ок'

        # ЗАБЛОКИРОВАНО
        2.times do |i|
          checkbox = all(:css, "table input[type=checkbox]")[i].native.attribute('id')
          uncheck checkbox
        end

        first(:css, ".btn.btn-primary.dropdown-toggle").click
        click_link 'form_pre_supplier_action'

        wait_until do
          has_content? 'Смена статуса'
        end

        click_button 'Ок'

        #ЗАКАЗАНО
        2.times do |i|
          checkbox = all(:css, "table input[type=checkbox]")[i].native.attribute('id')
          uncheck checkbox
        end

        first(:css, ".btn.btn-primary.dropdown-toggle").click
        click_link 'form_post_supplier_action'

        wait_until do
          has_content? 'Смена статуса'
        end

        case rand(0..1)
        when 0 
          select('8-я миля', :from => 'supplier_id')
        when 1
          select('Авториф', :from => 'supplier_id')
        end

        click_button 'Ок'

        wait_until do
          page.should have_content('Товар заказан у поставщика')
        end

        #ПОЛУЧЕНО
        2.times do |i|
          checkbox = all(:css, "table input[type=checkbox]")[i].native.attribute('id')
          uncheck checkbox
        end

        first(:css, ".btn.btn-primary.dropdown-toggle").click
        click_link 'form_stock_action'

        wait_until do
          has_content? 'Смена статуса'
        end

        click_button 'Ок'

        #ВЫДАНО
        2.times do |i|
          checkbox = all(:css, "table input[type=checkbox]")[i].native.attribute('id')
          uncheck checkbox
        end

        first(:css, ".btn.btn-primary.dropdown-toggle").click
        click_link 'form_complete_action'

        wait_until do
          has_content? 'Смена статуса'
        end

        click_button 'Ок'

      end
      
    end
  end
end




