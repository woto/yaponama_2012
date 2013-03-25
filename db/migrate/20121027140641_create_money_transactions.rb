class CreateMoneyTransactions < ActiveRecord::Migration
  def change
    create_table :money_transactions do |t|
      t.references :account
      t.references :product_transaction
      # TODO
      # Попробовать потом удалить поля credit и debit
      t.decimal :credit, :precision => 8, :scale => 2
      t.decimal :debit, :precision => 8, :scale => 2
      # TODO
      # Переименовать в log_... (Как например в ProductTransaction. Выдерживать общий стиль)
      t.string :credit_log
      t.string :debit_log
      t.text :notes
      t.integer :creator_id

      t.timestamps
    end
  end
end
