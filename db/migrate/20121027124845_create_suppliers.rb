class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :name
      t.datetime :activity_at

      t.timestamps
    end
  end
end
