class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.integer :price
      t.integer :awaiting
      t.integer :reach
      t.text :comment
      t.inet :remote_ip

      t.timestamps null: false
    end
  end
end
