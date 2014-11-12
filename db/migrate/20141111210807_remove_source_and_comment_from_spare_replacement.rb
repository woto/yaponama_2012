class RemoveSourceAndCommentFromSpareReplacement < ActiveRecord::Migration
  def change
    remove_column :spare_replacements, :source, :string
    remove_column :spare_replacements, :comment, :string
  end
end
