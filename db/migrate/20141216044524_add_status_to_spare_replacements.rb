class AddStatusToSpareReplacements < ActiveRecord::Migration
  def change
    add_column :spare_replacements, :status, :integer
  end
end
