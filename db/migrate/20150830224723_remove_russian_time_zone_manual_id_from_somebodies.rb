class RemoveRussianTimeZoneManualIdFromSomebodies < ActiveRecord::Migration
  def change
    remove_column :somebodies, :russian_time_zone_manual_id, :string
  end
end
