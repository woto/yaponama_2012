class AddProfileableFields < ActiveRecord::Migration
  def change
    [:phones, :names, :email_addresses, :postal_addresses].each do |table|
      add_column table, :creation_reason, :string
      add_column table, :notes, :text
      add_column table, :notes_invisible, :text
      add_column table, :removed, :boolean

      add_column table, :user_id, :integer
      add_column table, :creator_id, :integer

      add_index table, :user_id, name: "index_#{table}_on_user_id"
      add_index table, :creator_id, name: "index_#{table}_on_creator_id"
    end
  end
end
