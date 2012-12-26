class CreateAdminBlocks < ActiveRecord::Migration
  def change
    create_table :admin_blocks do |t|
      t.text :content
      t.string :name

      t.timestamps
    end
  end
end
