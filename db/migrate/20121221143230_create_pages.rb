class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :path
      t.text :content
      t.text :keywords
      t.text :description
      t.string :title
      t.string :robots
      t.integer :creator_id

      t.timestamps
    end
  end
end
