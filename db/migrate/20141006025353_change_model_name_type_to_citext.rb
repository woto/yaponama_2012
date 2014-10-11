class ChangeModelNameTypeToCitext < ActiveRecord::Migration
  def change
    change_column :models, :name,  :citext
  end
end
