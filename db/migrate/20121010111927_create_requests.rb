class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.references :user
      t.references :car
      t.string :catalog_number
      t.string :manufacturer
      t.text :notes
      t.string :invisible

      t.timestamps
    end
    add_index :requests, :user_id
    add_index :requests, :car_id
  end
end
