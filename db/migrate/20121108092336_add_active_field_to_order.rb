class AddActiveFieldToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :active, :string
  end
end
