class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :money_available, :default => 0
      t.integer :money_locked, :default => 0
      t.references :accountable, :polymorphic => true
      t.string :name

      t.timestamps
    end
  end
end
