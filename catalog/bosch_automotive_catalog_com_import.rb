class BoschAutomotiveCatalogComImport
  def self.bosch_automotive_catalog_com_import
    dir = File.join(Rails.root, 'catalog', 'bosch_automotive_catalog_com')
    #[File.join(dir, "0092S40130")].each do |directory_with_catalog_number|
    Dir.glob("#{dir}/*").each do |directory_with_catalog_number|
      catalog_number = File.basename directory_with_catalog_number
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
        catalog_number: PriceMate.catalog_number(catalog_number),
        brand: bosch,
      })
      spare_info.assign_attributes(images_hash.merge(hstore: opts_hash).merge(spare_catalog_hash))
      spare_info.save!

      case opts_hash['Наименование']
      when /аккумулятор/
        accumulator_hash = {}
        accumulator_hash['length'] = opts_hash.delete 'Длина'
        accumulator_hash['width'] = opts_hash.delete 'Ширина'
        accumulator_hash['height'] = opts_hash.delete 'Высота с полюсом'
        accumulator_hash['voltage'] = opts_hash.delete 'Напряжение аккум. батареи'
        accumulator_hash['battery_capacity'] = opts_hash.delete 'Ном. емкость'
        accumulator_hash['cold_cranking_amps'] = opts_hash.delete 'Исп. ток н.т.(EN 60095-1)'
        accumulator_hash['base_hold_down'] = opts_hash.delete 'Нижняя пластина'
        accumulator_hash['layout'] = opts_hash.delete 'Тип полюсного вывода'
        #terminal_types: Токовыводы / Клеммы
        #case_size: Размеры корпуса
        #weight_filled: Масса (в незалитом виде)

        spare_info.create_accumulator!(accumulator_hash)
      end


    end
  end
end
