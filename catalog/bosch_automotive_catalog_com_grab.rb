require '_capybara'

class BoschAutomotiveCatalogComGrab < ActionDispatch::IntegrationTest

  def self.bosch_automotive_catalog_com_grab
    agent = Mechanize.new
    bosch = BrandMate.find_canonical("BOSCH")

    SpareInfo.where(brand: bosch).order("RANDOM()").each do |si|
      begin
        visit "http://www.bosch-automotive-catalog.com/ru/product-detail/-/product/#{si.catalog_number}"
        spare_dir = File.join(Rails.root, 'catalog', 'bosch_automotive_catalog_com', si.catalog_number)

        all('.bordercontainer img', visible: false).each_with_index do |image, index|
          image_url = image['src']
          unless [/zoom\.gif/, /no-image-362x362\.jpg/].any?{|regex| image_url.match(regex)}
            images_dir = File.join(spare_dir, 'images')
            FileUtils.mkdir_p images_dir
            image_dir = File.join(images_dir, index.to_s)
            begin
              downloaded_image = agent.get(image_url)
              raise Exception if downloaded_image.content.size <= 1000
            rescue
              puts "retry #{image_url}"
              retry
            end
            downloaded_image.save!(File.join(image_dir, downloaded_image.filename))
          end
        end

        all('.tabs li').each_with_index do |li, li_index|
          case li_index
          when 0
            FileUtils.mkdir_p spare_dir
            File.open(File.join(spare_dir, 'opts'), 'wb') do |fo|
              li.all('tr', visible: false).each_with_index do |tr, tr_index|
                tr.all('td', visible: false).each_with_index do |td, td_index|
                  fo.write "#{td['innerHTML']}\n" if td_index < 2
                end
              end
            end
          when 1
            FileUtils.mkdir_p spare_dir
            File.open(File.join(spare_dir, 'reps'), 'wb') do |fo|
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
        puts e.backtrace.join("\n")
        #binding.pry
      ensure
        sleep 10
      end
    end
  end
end
