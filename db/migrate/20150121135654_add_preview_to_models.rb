class AddPreviewToModels < ActiveRecord::Migration
  def change
    add_column :models, :preview, :text
  end
end
