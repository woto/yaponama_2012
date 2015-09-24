class BrandChainJob < ActiveJob::Base
  queue_as :default

  # Стоит не забывать, что если такая деталь уже есть (например делаем у KI родителем производителя KIA).
  # И есть в обоих случаях деталь 2102 (KI) и 2102 (KIA). То валидация на уникальность в Описаниях не пропустит.
  # В связи с этим Замены и Применимость так же останутся в лимбе.

  def perform(brand)
    conglomerate = BrandMate::find_conglomerate_by_id(brand.id)
    company = BrandMate::find_company_by_id(brand.id)

    [:spare_infos, :products].each do |table|
      brand.send(table).find_each do |row|
        row.update(brand: conglomerate)
      end
    end

    [:models, :cars, :spare_applicabilities].each do |table|
      brand.send(table).find_each do |row|
        row.update(brand: company)
      end
    end

  end
end
