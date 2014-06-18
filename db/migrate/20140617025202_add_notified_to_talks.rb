class AddNotifiedToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :notified, :boolean, default: false
  end
end
