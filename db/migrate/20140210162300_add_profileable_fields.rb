class AddProfileableFields < ActiveRecord::Migration
  def change
    [:postal_addresses, :cars, :products, :orders].each do |table|
      add_column table, :creation_reason, :string
      add_column table, :notes, :text, :default => ''
      add_column table, :notes_invisible, :text, :default => ''

      add_column table, :somebody_id, :integer
      add_column table, :creator_id, :integer

      add_index table, :somebody_id, name: "index_#{table}_on_somebody_id"
      add_index table, :creator_id, name: "index_#{table}_on_creator_id"
    end
  end
end
