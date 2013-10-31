class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.references :creator, index: true
      # rrda
      #t.string :name

      t.decimal :debit, :default => 0, :precision => 8, :scale => 2
      t.decimal :credit, :default => 0, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
