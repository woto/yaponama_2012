require '_capybara'

class BoschAutomotiveCatalogComGrab < ActionDispatch::IntegrationTest
  def self.bosch_automotive_catalog_com_grab
    agent = Mechanize.new
    bosch = BrandMate.find_canonical("BOSCH")

    SpareInfo.where(brand: bosch).order("RANDOM()").each do |si|
      begin
        dir = File.join(Rails.root, 'catalog', 'bosch_automotive_catalog_com', si.catalog_number)
        FileUtils.mkdir_p dir

        visit "http://www.bosch-automotive-catalog.com/ru/product-detail/-/product/#{si.catalog_number}"

        all('.bordercontainer img', visible: false).each_with_index do |image, index|
          image_url = image['src']
          unless [/zoom\.gif/, /no-image-362x362\.jpg/].any?{|regex| image_url.match(regex)}
            image_dir = File.join(dir, 'images', index.to_s)
            FileUtils.mkdir_p image_dir

            downloaded_image = agent.get(image_url)
            downloaded_image.save!(File.join(image_dir, downloaded_image.filename))
          end
        end

        all('.tabs li').each_with_index do |li, li_index|
          case li_index
          when 0
            File.open(File.join(dir, 'opts'), 'wb') do |fo|
              li.all('tr', visible: false).each_with_index do |tr, tr_index|
                tr.all('td', visible: false).each_with_index do |td, td_index|
                  fo.write "#{td['innerHTML']}\n" if td_index < 2
                end
              end
            end
          when 1
            File.open(File.join(dir, 'reps'), 'wb') do |fo|
              li.all('tr', visible: false).each_with_index do |tr, tr_index|
                tr.all('td', visible: false).each_with_index do |td, td_index|
                  fo.write "#{td['innerHTML']}\n"
                end
              end
            end
          end
        end

      rescue Exception => e
        puts e.message
        puts si.catalog_number
        #binding.pry
      ensure
        sleep 10
      end
    end
  end
end
