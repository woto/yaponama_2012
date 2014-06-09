class AddPeriodsToGenerations < ActiveRecord::Migration
  def change
    add_column :generations, :from, :date
    add_column :generations, :to, :date
  end
end
