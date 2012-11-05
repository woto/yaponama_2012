class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.decimal :debit, :default => 0, :decimal, :precision => 8, :scale => 2
      t.decimal :credit, :default => 0, :decimal, :precision => 8, :scale => 2
      t.references :accountable, :polymorphic => true
      t.string :name

      t.timestamps
    end
  end
end
