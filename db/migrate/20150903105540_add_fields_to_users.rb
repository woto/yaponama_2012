class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_agent, :text
    add_column :users, :accept_language, :text
    add_column :users, :location, :text
    add_column :users, :referrer, :text
    add_column :users, :first_referrer, :text
    add_column :users, :credit, :integer, default: 0, nil: false
    add_column :users, :debit, :integer, default: 0, nil: false
    add_column :users, :role, :integer
    add_column :users, :name, :string
    add_column :users, :phone, :string
  end
end
