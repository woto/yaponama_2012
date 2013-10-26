class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.integer :god
      t.string :period
      t.string :brand
      t.string :model
      t.string :generation
      t.string :modification
      t.string :dvigatel
      t.string :tip
      t.string :moschnost
      t.string :privod
      t.string :tip_kuzova
      t.string :kpp
      t.string :kod_kuzova
      t.string :kod_dvigatelya
      t.string :rinok
      t.string :vin
      t.string :frame
      t.string :vin_or_frame
      t.string :komplektaciya
      t.integer :dverey
      t.string :rul
      t.timestamps
    end

  end
end
