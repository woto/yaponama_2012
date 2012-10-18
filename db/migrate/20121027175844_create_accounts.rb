class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.decimal :debit, :decimal, :default => 0, :precision => 8, :scale => 2
      t.decimal :credit, :decimal, :default => 0, :precision => 8, :scale => 2
      t.references :accountable, :polymorphic => true

      t.timestamps
    end
  end
end
