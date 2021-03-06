class UpdateSpareReplacementsEnumStatuses < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        SpareReplacement.where(status: 2).delete_all
        SpareReplacement.where(status: 3).update_all(status: 2)
      end
    end
  end
end
