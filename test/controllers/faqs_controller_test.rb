require 'test_helper'

class FaqsControllerTest < ActionDispatch::IntegrationTest

  test 'Мы можем просмотреть список частых вопросов' do
    get faqs_path
    assert_select '.panel-group' do
      assert_select '.panel.panel-default' do
        assert_select '.panel-heading[data-clickable-object]' do
          assert_select '.panel-title' do
            assert_select 'a[data-clickable-href][faq-translocation][href="/faqs#14"]', text: 'Описание раздела Частые вопросы'
          end
        end
        assert_select '#faq-collapse-14.faq-collapse.panel-collapse.collapse' do
          assert_select '.panel-body.discourse-cooked' do
            assert_select '*', text: /В данном разделе мы размещаем наиболее/
            assert_select "a:match('href', ?)", /\/faqs\/14/ do |a|
              assert_select '*', text: 'Открыть в новом окне'
            end
          end
        end
      end
    end
  end

  test 'Просмотр частого вопроса' do
    get faq_path(14)
    assert_select '[screen-margin]' do
      assert_select 'h1', 'Описание раздела Частые вопросы'
      assert_select '.hidden-print' do
        assert_select 'a[href="#"][onclick="window.print()"]', text: 'Распечатать'
      end
      assert_select '.discourse-cooked' do
        assert_select '*', text: /В данном разделе мы размещаем наиболее/
      end
    end
    assert_template 'lightweight'
  end
end
