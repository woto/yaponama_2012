class CreateNames < ActiveRecord::Migration
  def change
    create_table :names do |t|
      t.string :name
      t.references :profile, index: true

      t.timestamps
    end
  end
end
