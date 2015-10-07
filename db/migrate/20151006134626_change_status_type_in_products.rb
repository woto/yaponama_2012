class ChangeStatusTypeInProducts < ActiveRecord::Migration
  def change
    change_column :products, :status, "integer USING (
    CASE status 
      WHEN 'incart' THEN 0 
      WHEN 'inorder' THEN 1
      WHEN 'ordered' THEN 2
      WHEN 'pre_supplier' THEN 3
      WHEN 'post_supplier' THEN 4
      WHEN 'stock' THEN 5
      WHEN 'complete' THEN 6
      WHEN 'cancel' THEN 7
    END)".squish
  end
end
