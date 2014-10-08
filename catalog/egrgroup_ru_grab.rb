require 'test_helper'
require 'csv'

class EgrgroupRuGrab < ActionDispatch::IntegrationTest
  test 'egrgroup_ru_grab' do
    path = File.join(Rails.root, 'catalog', 'egrgroup_ru.csv')
    CSV.open(path, "wb") do |csv|
      visit 'http://egrgroup.ru'
      links = all('td.dtree a').map{|el| {'title' => el.text, 'url' => el['href']}}
      links.each_with_index do |link, index|
        #if index < 1
          visit link['url']
          # Убеждаемся, что странца с заголовком ссылки загрузилась
          assert has_selector? 'td.hd.bf', text: link['title']
          begin
            click_link 'показать все', match: :first, wait: 1
          rescue
          end
          all('.bl td.hdbtop').each_with_index do |el, index|
            #if index < 1
              array = el.native.text.split("\n")

              kod_tovara = array.grep(/Код товара: /)[0].to_s.gsub("Код товара: ", "")
              god_vipuska = array.grep(/Год выпуска: /)[0].to_s.gsub("Год выпуска: ", "")
              marka = array.grep(/Марка: /)[0].to_s.gsub("Марка: ", "")
              model = array.grep(/Модель: /)[0].to_s.gsub("Модель: ", "")
              proizvoditel = array.grep(/Производитель: /)[0].to_s.gsub("Производитель: ", "")
              tip_izdeliya = array.grep(/Тип изделия: /)[0].to_s.gsub("Тип изделия: ", "")
              if proizvoditel.blank?
                proizvoditel = 'NORPLAST'
              end
              cost = array[0]
              #binding.pry
              csv << [cost, kod_tovara, god_vipuska, marka, model, proizvoditel, tip_izdeliya, array[array.length-2]]
              csv.flush
            #end
          end
        #end
      end
    end
  end
end
