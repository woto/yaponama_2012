class CreateAdminDeliveryCategories < ActiveRecord::Migration
  def change
    create_table :delivery_categories do |t|
      t.string :name
      t.text :notes
      t.text :notes_invisible

      t.timestamps
    end
  end
end
