class VartaAutomotiveRuImport
  def self.varta_automotive_ru_import
    dir = File.join(Rails.root, 'catalog', 'varta_automotive_ru')
    Dir.glob("#{dir}/*/*").each do |directory_with_catalog_number_and_line|
      catalog_number = File.basename directory_with_catalog_number_and_line
      varta = BrandMate.find_or_create_canonical!('VARTA')

      images_hash = {}
      ['main', 'base_hold_down', 'layout', 'terminal_types'].each_with_index do |image_dir, index|
        image_path = Dir.glob(File.join(directory_with_catalog_number_and_line, image_dir, '*'))
        raise "#{image_dir} many" if image_path.many?
        if image_path.one?
          images_hash["image#{index+1}"] = File.open(image_path.first)
        end
      end

      opts_hash = {}
      key = nil
      File.readlines(File.join(directory_with_catalog_number_and_line, 'opts')).each_with_index do |line, index|
        line.strip!
        key = line if index.even?
        opts_hash[key] = line if index.odd?
      end

      spare_catalog_hash = {spare_catalog: PriceMate.spare_catalog}

      spare_info = SpareInfo.find_or_initialize_by({
        catalog_number: PriceMate.catalog_number(catalog_number),
        brand: varta
      })

      spare_info.assign_attributes(images_hash.merge(hstore: opts_hash).merge(spare_catalog_hash))
      spare_info.save!

      accumulator_hash = {}
      accumulator_hash['voltage'] = opts_hash.delete 'Напряжение:'
      accumulator_hash['battery_capacity'] = opts_hash.delete 'Емкость:'
      accumulator_hash['cold_cranking_amps'] = opts_hash.delete 'Ток холодной прокрутки:'
      accumulator_hash['length'] = opts_hash.delete 'Продолжительность:'
      accumulator_hash['width'] = opts_hash.delete 'Ширина:'
      accumulator_hash['height'] = opts_hash.delete 'Высота:'
      spare_info.create_accumulator!(accumulator_hash)
    end
  end
end

