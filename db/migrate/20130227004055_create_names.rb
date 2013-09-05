class CreateNames < ActiveRecord::Migration
  def change
    create_table :names do |t|
      t.string :surname
      t.string :name
      t.string :patronymic
      t.references :profile, index: true

      t.timestamps
    end
  end
end
