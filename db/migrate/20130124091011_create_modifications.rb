class CreateModifications < ActiveRecord::Migration
  def change
    create_table :modifications do |t|
      t.string :name
      t.references :generation, index: true
      t.references :creator, index: true

      t.timestamps
    end
  end
end
