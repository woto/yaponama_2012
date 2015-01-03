class CreateCallbacks < ActiveRecord::Migration
  def change
    create_table :callbacks do |t|
      t.string :name
      t.string :phone
      t.references :somebody, index: true

      t.timestamps null: false
    end
    add_foreign_key :callbacks, :somebodies
  end
end
