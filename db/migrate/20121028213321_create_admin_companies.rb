class CreateAdminCompanies < ActiveRecord::Migration
  def change
    create_table :admin_companies do |t|
      t.string :inn
      t.string :kpp
      t.string :name
      t.string :bank_account
      t.string :account
      t.string :correspondent_account
      t.string :bic

      t.timestamps
    end
  end
end
