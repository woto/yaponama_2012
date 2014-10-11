class ChangeGenerationNameTypeToCitext < ActiveRecord::Migration
  def change
    change_column :generations, :name,  :citext
  end
end
