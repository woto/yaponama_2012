require 'csv'

class UnloadConglomerates
  def self.unload_conglomerates
    CSV.open("file.csv", "wb") do |csv|
      Brand.joins(:spare_infos).group("brands.id").having("count(spare_infos.id) > 1").find_each do |brand|
        brand.brands.each do |b|
          csv << [brand.name, b.name]
        end
      end
    end
  end
end
