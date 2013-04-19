class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.references :brand, index: true
      t.string :name
      t.references :creator, index: true

      t.timestamps
    end
  end
end
