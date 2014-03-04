class AddBotToSomebodies < ActiveRecord::Migration
  def change
    add_column :somebodies, :bot, :boolean, default: false
  end
end
