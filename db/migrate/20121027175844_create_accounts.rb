class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :debit, :default => 0
      t.integer :credit, :default => 0
      t.references :accountable, :polymorphic => true
      t.string :name

      t.timestamps
    end
  end
end
