# TAB-203 (содержит фотографию модели, которая у меня не подхватывается)

require '_capybara'

class FebestDeGrab < ActionDispatch::IntegrationTest
  def self.febest_de_grab
    febest = BrandMate.find_conglomerate("FEBEST")
    visit "http://febest.de/index.php?page=catalog"
    fill_in 'code', with: si.catalog_number
    click_button 'Найти'
    link = first('#detgrid table tr.odd a')
    if link
      link.click
      puts si.catalog_number
      spare_dir = File.join(Rails.root, 'catalog', 'febest_de', si.catalog_number)
      FileUtils.mkdir_p spare_dir

      title = first('#detPartHead').text
      File.open(File.join(spare_dir, 'title'), 'wb') do |fo|
        fo.puts title
      end

      phrase = first('#detPartCode').text.gsub('Артикул: ', '')
      File.open(File.join(spare_dir, 'phrase'), 'wb') do |fo|
        fo.puts phrase
      end

      replacements = []
      all('#oem option').each do |replacement|
        replacements << replacement.text
      end
      replacements.reject!{|c| c.empty?}
      File.open(File.join(spare_dir, 'replacements'), 'wb') do |fo|
        replacements.each do |replacement|
          fo.puts replacement
        end
      end

      applicabilities = []
      all('#model_list option').each do |applicability|
        applicabilities << applicability.text
      end
      File.open(File.join(spare_dir, 'applicabilities'), 'wb') do |fo|
        applicabilities.each do |applicability|
          fo.puts applicability
        end
      end

      images_dir = File.join(spare_dir, 'images')
      all('#detimg img').each_with_index do |image, index|
        image_url = image['src']
        FileUtils.mkdir_p images_dir
        image_dir = File.join(images_dir, index.to_s)
        agent = Mechanize.new
        downloaded_image = agent.get(image_url)
        downloaded_image.save!(File.join(image_dir, downloaded_image.filename))
      end
    end
    sleep 3
  end
end
