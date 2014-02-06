class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :amount
      t.references :creator, index: true
      t.references :somebody, index: true
      t.references :profile, index: true
      t.references :postal_address, index: true
      #t.references :company, index: true
      t.string :payment_type

      t.timestamps
    end
  end
end
