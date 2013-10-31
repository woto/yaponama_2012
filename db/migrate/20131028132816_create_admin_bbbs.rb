class CreateAdminBbbs < ActiveRecord::Migration
  def change
    create_table :admin_bbbs do |t|
      t.string :name
      t.text :content

      t.timestamps
    end
  end
end
