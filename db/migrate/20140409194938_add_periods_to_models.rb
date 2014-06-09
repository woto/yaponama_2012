class AddPeriodsToModels < ActiveRecord::Migration
  def change
    add_column :models, :from, :date
    add_column :models, :to, :date
  end
end
