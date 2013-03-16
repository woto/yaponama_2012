class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.string :name
      t.text :notes
      t.text :notes_invisible
      t.boolean :available

      t.timestamps
    end
  end
end
