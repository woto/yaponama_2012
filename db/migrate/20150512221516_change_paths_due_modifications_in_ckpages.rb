class ChangePathsDueModificationsInCkpages < ActiveRecord::Migration
  def change
    Ckpages::Page.update_all("path = CONCAT('/', path)")
  end
end
