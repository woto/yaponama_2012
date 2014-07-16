class RemoveTransportFieldFromSomebodyTransaction < ActiveRecord::Migration
  def change
    remove_column :somebody_transactions, :transport_before, :string
    remove_column :somebody_transactions, :transport_after, :string
  end
end
