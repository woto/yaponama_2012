require '_capybara'

class FebestDeGrab < ActionDispatch::IntegrationTest
  def self.febest_de_grab
    febest = BrandMate.find_canonical("FEBEST")
    visit "http://febest.de/index.php?page=catalog"
    febest.spare_infos.each do |si|
      fill_in 'code', with: si.catalog_number
      click_button 'Найти'
      sleep 10
    end
  end
end
