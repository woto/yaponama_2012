class ChangeBrandNameTypeToCitext < ActiveRecord::Migration
  def change
    change_column :brands, :name,  :citext
  end
end
