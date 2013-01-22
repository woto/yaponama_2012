class CreateAdminModels < ActiveRecord::Migration
  def change
    create_table :admin_models do |t|
      t.integer :brand_id
      t.string :name
      t.integer :creator_id

      t.timestamps
    end
  end
end
