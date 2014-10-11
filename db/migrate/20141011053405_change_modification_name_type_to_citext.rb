class ChangeModificationNameTypeToCitext < ActiveRecord::Migration
  def change
    change_column :modifications, :name,  :citext
  end
end
