class CreatePassports < ActiveRecord::Migration
  def change
    create_table :passports do |t|
      t.string :seriya
      t.string :nomer
      t.string :passport_vidan
      t.date :data_vidachi
      t.string :kod_podrazdeleniya
      t.boolean :female
      t.date :data_rozhdeniya
      t.string :mesto_rozhdeniya
      t.references :profile, index: true

      t.timestamps
    end
  end
end
