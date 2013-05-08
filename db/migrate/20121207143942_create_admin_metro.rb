class CreateAdminMetro < ActiveRecord::Migration
  def change
    create_table :metro do |t|
      t.timestamps
    end
  end
end
