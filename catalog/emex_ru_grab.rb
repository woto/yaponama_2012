require '_capybara'

class EmexRuGrab < ActionDispatch::IntegrationTest

  def self.emex_ru_grab
    Deliveries::Place.find(5).warehouses.each do |warehouse|
      catalog_number = warehouse.spare_info.catalog_number
      catalog_number = '2102'
      brand = warehouse.spare_info.brand
      brand = BrandMate.find_conglomerate('Novline')
      visit "https://www.emex.ru/f?detailNum=#{catalog_number}&packet=-1"
      if has_text? "Найдено несколько совпадений"
        all('.brand-list .row').each_with_index do |row, index|
          if brand == BrandMate.find_conglomerate(row.first('.col').text)
            row.click
            $('')
            JDA192
            find('[data-bind="visible: sections.SearchedDetails.isVisible"] .photo').click
            break
          end
        end
      end
      sleep 20
    end
  end

end
