class BoschAutomotiveCatalogComImport
  def self.bosch_automotive_catalog_com_import
    dir = File.join(Rails.root, 'catalog', 'bosch_automotive_catalog_com')
    #[File.join(dir, "0092S40130")].each do |directory_with_catalog_number|
    Dir.glob("#{dir}/*").each do |directory_with_catalog_number|
      catalog_number = PriceMate.catalog_number(File.basename(directory_with_catalog_number))
      bosch = BrandMate.find_or_create_canonical!('BOSCH')

      images_paths = Dir.glob(File.join(directory_with_catalog_number, 'images', '*', '*'))
      images_paths.sort!
      images_hash = {}
      images_paths.each_with_index do |image_path, index|
        images_hash["image#{index+1}"] = File.open image_path
      end if images_paths.any?

      opts_hash = {}
      key = nil
      File.readlines(File.join(directory_with_catalog_number, 'opts')).each_with_index do |line, index|
        line.strip!
        key = line if index.even?
        opts_hash[key] = line if index.odd?
      end

      spare_catalog_hash = {spare_catalog: PriceMate.spare_catalog}

      spare_info = SpareInfo.find_or_initialize_by({
        catalog_number: catalog_number,
        brand: bosch,
      })

      case opts_hash['Наименование']
      when /аккумулятор/
        spare_catalog = SpareCatalog.find_by(opt: 'accumulator') || SpareCatalog.find_by(name: 'БАТАРЕЯ АККУМУЛЯТОРНАЯ')
        if spare_catalog.opt != 'accumulator' or spare_catalog.name != 'БАТАРЕЯ АККУМУЛЯТОРНАЯ'
          spare_catalog.update(opt: 'accumulator', name: 'БАТАРЕЯ АККУМУЛЯТОРНАЯ')
        end
        spare_catalog_hash = {spare_catalog: spare_catalog}

        accumulator_hash = {}

        length = opts_hash.delete('Длина')
        accumulator_hash['length'] = length.to_i
        width = opts_hash.delete('Ширина')
        accumulator_hash['width'] = width.to_i
        height = opts_hash.delete('Высота с полюсом')
        accumulator_hash['height'] = height.to_i
        voltage = opts_hash.delete('Напряжение аккум. батареи')
        accumulator_hash['voltage'] = Rails.application.config_for('application/opts/accumulator')['accumulator_voltage']['checkboxes'].find{|hash| hash[:label].to_i == voltage.to_i}[:value]
        battery_capacity = opts_hash.delete('Ном. емкость')
        accumulator_hash['battery_capacity'] = battery_capacity.to_i
        cold_cranking_amps = opts_hash.delete 'Исп. ток н.т.(EN 60095-1)'
        accumulator_hash['cold_cranking_amps'] = cold_cranking_amps.to_i
        base_hold_down = opts_hash.delete('Нижняя пластина')
        accumulator_hash['base_hold_down'] = case base_hold_down
          when 'B00'
            '0'
          when 'B01'
            '1'
          when 'B03'
            '3'
          when 'B13'
            '13'
          end
        terminal_types = opts_hash.delete('Тип полюсного вывода')
        accumulator_hash['terminal_types'] = case terminal_types
          when '1'
            '1'
          when '3'
            '3'
          end
        layout = opts_hash.delete('Переключатель')
        accumulator_hash['layout'] = case layout
          when '0'
            '0'
          when '1'
            '1'
          end
        accumulator_hash['layout'] = layout
        #case_size: Размеры корпуса
        #weight_filled: Масса (в незалитом виде)

        accumulator = spare_info.accumulator || spare_info.build_accumulator

        accumulator.assign_attributes(accumulator_hash)
        unless accumulator.save
          binding.pry
        end
      end

      replacements_catalog_numbers = []
      replacements_catalog_numbers << PriceMate.catalog_number(opts_hash.delete('Номер для заказа'))
      replacements_catalog_numbers << PriceMate.catalog_number(opts_hash.delete('Маркетинговый номер'))
      replacements_catalog_numbers << PriceMate.catalog_number(opts_hash.delete('Номер для поиска (KSN)'))
      replacements_catalog_numbers << PriceMate.catalog_number(opts_hash.delete('Краткое торг. обознач. (HKB)'))
      replacements_catalog_numbers << PriceMate.catalog_number(opts_hash.delete('Стандартное обозначение'))

      replacements_catalog_numbers.select!(&:present?)
      replacements_catalog_numbers.reject!{|obj| obj == catalog_number}


      spare_info.assign_attributes(images_hash.merge(hstore: opts_hash).merge(spare_catalog_hash))
      unless spare_info.save
        binding.pry
      end

      replacements_catalog_numbers.each do |replacement_catalog_number|
        to_spare_info = SpareInfo.where(catalog_number: replacement_catalog_number, brand: bosch).first_or_initialize
        to_spare_info.assign_attributes(spare_catalog: PriceMate.spare_catalog)
        unless to_spare_info.save
          binding.pry
        end

        spare_replacement = SpareReplacement.where(from_spare_info: spare_info, to_spare_info: to_spare_info).first_or_initialize
        spare_replacement.assign_attributes(status: 'same_number', notes_invisible: 'bosch_automotive_catalog_com_import', wrong: false)
        unless spare_replacement.save
          binding.pry
        end
      end


    end
  end
end
