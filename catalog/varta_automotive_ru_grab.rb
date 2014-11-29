require '_capybara'
require 'csv'
require 'mechanize'
require 'fileutils'

class VartaAutomotiveRuGrab < ActionDispatch::IntegrationTest

  def self.varta_automotive_ru_grab
    dir = 'varta_automotive_ru'
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
        FileUtils.mkdir_p etn_dir

        agent = Mechanize.new
        downloaded_image = agent.get(image_url)
        downloaded_image.save! File.join(etn_dir, downloaded_image.filename)

        agent = Mechanize.new
        downloaded_description = agent.get(description_url)
        downloaded_description.save! File.join(etn_dir, downloaded_description.filename)

        Capybara.session_name = :second
        visit etn_url

        File.open(File.join(etn_dir, 'details'), 'wb') do |fo|
          fo.write first('.details')['innerHTML']
        end

        if image = first('.terminal_types ~ .imgFile img')
          agent = Mechanize.new
          downloaded_image = agent.get(image['src'])
          downloaded_image.save! File.join(etn_dir, "terminal_types", downloaded_image.filename)
        end

        if image = first('.layout ~ .imgFile img')
          agent = Mechanize.new
          downloaded_image = agent.get(image['src'])
          downloaded_image.save! File.join(etn_dir, "layout", downloaded_image.filename)
        end

        if image = first('.base_hold_down ~ .imgFile img')
          agent = Mechanize.new
          downloaded_image = agent.get(image['src'])
          downloaded_image.save! File.join(etn_dir, "base_hold_down", downloaded_image.filename)
        end

        File.open(File.join(etn_dir, 'opts'), 'wb') do |fo|
          all('.specs', visible: false).each do |table|
            table.all('td', visible: false).each do |td|
              if td['colspan'] != '2'
                fo.write "#{td['innerHTML']}\n"
              end
            end
          end
          #all('.specs', visible: false).each do |table|
          #  table.all('tr', visible: false).each_with_index do |row, index|
          #    if index == 0
          #      title = row.first('h2', visible: false, match: :one)['innerHTML']
          #      next
          #    end
          #    File.open(File.join(etn_dir, title), 'wb') do |fo|
          #      row.all('td', visible: false)

          #    #binding.pry
          #    #spec.all('td', visible: false).each do |td|
          #    #  fo.write "#{td['innerHTML']}\n"
          #    #end
          #  end
          #end
        end

      end
    end
  end
end
