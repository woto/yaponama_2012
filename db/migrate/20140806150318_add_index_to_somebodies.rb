class AddIndexToSomebodies < ActiveRecord::Migration
  def change
      add_index :somebodies, [:type, :auth_token], unique: true
  end
end
