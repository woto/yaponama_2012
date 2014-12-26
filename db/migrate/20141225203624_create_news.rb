class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :title
      t.string :path
      t.text :intro
      t.text :body
      t.datetime :date
      t.references :creator

      t.timestamps null: false
    end
  end
end
