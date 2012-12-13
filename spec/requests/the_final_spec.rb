# encoding: utf-8

require 'spec_helper'

describe "TestControllers", :js => true do
  describe "GET /test_controllers", :js => true do
    it "works! (now write some real specs)", :js => true do
      full_filled_user = FactoryGirl.create(:full_filled_user)

      visit admin_user_products_path(full_filled_user)

      # Найти первый нужный чекбокс
      checkbox = first(:css, 'table input[type=checkbox]').native.attribute('id')
      check checkbox

      first(:css, ".btn.btn-primary.dropdown-toggle").click
      #find(:css, ".dropdown-menu>li[2]>a")
      click_link 'form_inorder_action'

      page.wait_until() do
        page.has_content? 'Выберите'
      end

      select('Новый заказ', :from => 'new_order_id')
      click_button 'Далее'

      page.wait_until() do
        page.has_content? 'Способ доставки'
      end

      select('Доставка по Москве -> Доставка до любой станции метро', :from => 'order_delivery_id')
      select('Динамо', :from => 'order_metro_id')
      click_button 'Создать'


      debugger


      #.dropdown-menu>li>a

      #debugger
      #save_screenshot('screenshot.png')
      get test_controllers_path
      response.status.should be(200)
    end
  end
end




