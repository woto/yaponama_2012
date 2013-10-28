class CreateAdminBlocks < ActiveRecord::Migration
  def change
    create_table :admin_blocks do |t|
      t.string :name
      t.text :content

      t.timestamps
    end
  end
end
