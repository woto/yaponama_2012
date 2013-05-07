class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :name
      t.text :content
      t.references :delivery

      t.timestamps
    end
  end
end
