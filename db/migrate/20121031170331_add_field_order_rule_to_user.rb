class AddFieldOrderRuleToUser < ActiveRecord::Migration
  def change
    add_column :users, :order_rule, :string
  end
end
