class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :ownership
      t.string :name
      t.string :inn
      t.string :kpp
      t.string :ogrn
      t.string :account
      t.string :bank
      t.string :bik
      t.string :correspondent
      t.string :okpo
      t.string :okved
      t.string :okato
      t.references :legal_address, index: true
      t.references :actual_address, index: true
      t.timestamps
    end
  end
end
