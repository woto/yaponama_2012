class MoveSlangToRelation < ActiveRecord::Migration
  def change
    Brand.where.not(slang: nil).each do |brand|
      Brand.create(brand: brand, name: brand.slang, sign: :slang)
    end
  end
end
