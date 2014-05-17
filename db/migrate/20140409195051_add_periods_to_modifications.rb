class AddPeriodsToModifications < ActiveRecord::Migration
  def change
    add_column :modifications, :from, :date
    add_column :modifications, :to, :date
  end
end
