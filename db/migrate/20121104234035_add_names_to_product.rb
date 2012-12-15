class AddNamesToProduct < ActiveRecord::Migration
  def change
    add_column :products, :short_name, :string, :default => ""
    add_column :products, :long_name, :text, :default => ""
  end
end
