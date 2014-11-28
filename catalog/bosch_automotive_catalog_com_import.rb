class BoschAutomotiveCatalogComImport
  def self.bosch_automotive_catalog_com_import
      dir = File.join(Rails.root, 'catalog', 'bosch_automotive_catalog_com')
      Dir.glob("#{dir}/*").each do |directory_with_catalog_number|
        begin
          hash = {}
          key = nil
          File.readlines(File.join(directory_with_catalog_number, 'opts')).each_with_index do |line, index|
            line.strip!
            key = line if index.even?
            hash[key] = line if index.odd?
          end
          catalog_number = File.basename directory_with_catalog_number
          Hstore.create catalog_number: catalog_number, hstore: hash
        rescue Exception => e
          puts e.message
        end
      end
  end
end

