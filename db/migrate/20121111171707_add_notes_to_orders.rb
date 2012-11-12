class AddNotesToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :notes, :text
    add_column :orders, :notes_invisible, :text
  end
end
