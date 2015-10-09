class AddTitleAndTitleToProducts < ActiveRecord::Migration
  def change
    rename_column :products, :short_name, :title
    rename_column :products, :long_name, :titles
    change_column :products, :titles, "text[] USING (string_to_array(titles, ','))"
    change_column :products, :titles, :text, array: true, default: '{}'
  end
end
