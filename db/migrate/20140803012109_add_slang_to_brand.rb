class AddSlangToBrand < ActiveRecord::Migration
  def change
    add_column :brands, :slang, :string
  end
end
