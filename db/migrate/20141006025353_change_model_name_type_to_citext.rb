class ChangeModelNameTypeToCitext < ActiveRecord::Migration
  def change
    enable_extension("citext")
    change_column :models, :name,  :citext
  end
end
