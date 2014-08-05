class AddSlangToModel < ActiveRecord::Migration
  def change
    add_column :models, :slang, :string
  end
end
