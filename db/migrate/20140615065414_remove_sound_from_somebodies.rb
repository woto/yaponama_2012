class RemoveSoundFromSomebodies < ActiveRecord::Migration
  def change
    remove_column :somebodies, :sound, :boolean
  end
end
