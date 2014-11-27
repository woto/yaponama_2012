require '_capybara'
require 'csv'
require 'mechanize'
require 'fileutils'

class VartaAutomotiveRuGrab < ActionDispatch::IntegrationTest

  def self.varta_automotive_ru_grab
    path = File.join(Rails.root, 'catalog', 'varta_automotive_com.csv')
    dir = 'varta_automotive_ru'
    CSV.open(path, 'wb') do |csv|
        {
          'silver-dynamic' => 'http://www.varta-automotive.ru/ru-ru/products/automotive/silver-dynamic/',
          'blue-dynamic' => 'http://www.varta-automotive.ru/ru-ru/products/automotive/blue-dynamic/',
          'black-dynamic' => 'http://www.varta-automotive.ru/ru-ru/products/automotive/black-dynamic/'
        }.each do |line,  url|
        Capybara.session_name = :first
        visit url
        all('table.battery_list tr').each_with_index do |row, i|
          next if i == 0

          arr = row.all('td')
          links = arr[1].all('a')
          etn = links[0]['innerHTML']

          etn_url = links[0]['href']
          image_url = links[2]['href']
          description_url = links[1]['href']

          etn_dir = File.join(Rails.root, 'catalog', dir, line, etn)

          image_dir = File.join(etn_dir, 'image')
          FileUtils.mkdir_p image_dir

          description_dir = File.join(etn_dir, 'description')
          FileUtils.mkdir_p description_dir

          agent = Mechanize.new

          downloaded_image = agent.get(image_url)
          downloaded_description = agent.get(description_url)

          downloaded_image.save! File.join(image_dir, downloaded_image.filename)
          downloaded_description.save! File.join(description_dir, downloaded_description.filename)

          Capybara.session_name = :second
          visit etn_url

          File.open(File.join(etn_dir, 'opts'), 'wb') do |fo|
            all('.specs', visible: false).each do |spec|
              spec.all('td', visible: false).each do |td|
                fo.write "#{td['innerHTML']}\n"
              end
            end
          end

          ##etn = PriceMate.catalog_number(arr[1].scan(/(?<=ETN: )\d+(?= )/)[0])
          #voltage = arr[2].scan(/\d+/)[0]
          #battery_capacity = arr[3].scan(/\d+/)[0]
          #cold_cranking_amps = arr[4].scan(/\d+/)[0]
          #weight = arr[5].scan(/\d+/)[0]
          #length, width, height = arr[6].scan(/\d+/)

          #csv << [etn, voltage, battery_capacity, cold_cranking_amps, weight, length, width, height]

        end
      end
    end

  end
end
