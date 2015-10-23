class FebestDeImport
  def self.febest_de_import
    dir = File.join(Rails.root, 'catalog', 'febest_de')
    febest = BrandMate.find_or_create_conglomerate('FEBEST')
    Dir.glob("#{dir}/*").each do |directory_with_catalog_number|
      puts directory_with_catalog_number

      catalog_number = PriceMate.catalog_number(File.basename(directory_with_catalog_number))

      images_paths = Dir.glob(File.join(directory_with_catalog_number, 'images', '*', '*'))
      images_paths.sort!
      images_hash = {}
      images_paths.each_with_index do |image_path, index|
        images_hash["image#{index+1}"] = File.open image_path
      end

      spare_catalog_hash = {spare_catalog: Defaults.spare_catalog}

      spare_info = SpareInfo.find_or_initialize_by({
        catalog_number: catalog_number,
        brand: febest,
      })

      spare_info.assign_attributes(images_hash)
      spare_info.assign_attributes(spare_catalog_hash) unless spare_info.fix_spare_catalog

      unless spare_info.save
        puts spare_info.to_label
      end

    end
  end
end
