class UpdateBrand
  def self.update_brand
    [SpareInfo, Model, Car, Product, SpareApplicability].each do |table|
      table.all.each do |row|
        if row.brand.brand
          row.brand = row.brand.brand
          puts " #{table} #{row.id}" unless row.save
        end
      end
    end
  end
end
