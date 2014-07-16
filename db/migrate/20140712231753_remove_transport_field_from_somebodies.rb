class RemoveTransportFieldFromSomebodies < ActiveRecord::Migration
  def change
    remove_column :somebodies, :transport, :string
  end
end
