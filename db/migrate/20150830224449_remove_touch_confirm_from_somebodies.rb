class RemoveTouchConfirmFromSomebodies < ActiveRecord::Migration
  def change
    remove_column :somebodies, :touch_confirm, :string
  end
end
