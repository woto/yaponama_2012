class CreateMoneyTransactions < ActiveRecord::Migration
  def change
    create_table :money_transactions do |t|
      t.references :left_account
      t.references :right_account
      t.boolean :left_real
      t.boolean :right_real
      t.decimal :left_money, :precision => 8, :scale => 2
      t.decimal :right_money, :precision => 8, :scale => 2
      t.text :notes
      t.references :documentable, :polymorphic => true

      t.timestamps
    end
  end
end
