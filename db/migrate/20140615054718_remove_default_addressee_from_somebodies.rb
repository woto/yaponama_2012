class RemoveDefaultAddresseeFromSomebodies < ActiveRecord::Migration
  def change
    remove_column :somebodies, :default_addressee_id, :integer
  end
end
