class RemoveCachedFieldsFromSpareApplicabilities < ActiveRecord::Migration
  def change
    remove_column :spare_applicabilities, :cached_brand, :string
    remove_column :spare_applicabilities, :cached_model, :string
    remove_column :spare_applicabilities, :cached_generation, :string
    remove_column :spare_applicabilities, :cached_modification, :string
  end
end
