class AddNamesToProduct < ActiveRecord::Migration
  def change
    add_column :products, :short_name, :string
    add_column :products, :long_name, :text
  end
end
