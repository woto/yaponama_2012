class RemoveUseAutoRussianTimeZoneFromSomebodies < ActiveRecord::Migration
  def change
    remove_column :somebodies, :use_auto_russian_time_zone, :string
  end
end
