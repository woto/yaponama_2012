class AddTransportToSomebodies < ActiveRecord::Migration
  def change
    add_column :somebodies, :transport, :string
  end
end
