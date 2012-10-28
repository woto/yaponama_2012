class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :left_account
      t.references :right_account
      t.boolean :left_real
      t.boolean :right_real
      t.integer :left_money
      t.integer :right_money
      t.text :notes
      t.references :documentable, :polymorphic => true

      t.timestamps
    end
  end
end
