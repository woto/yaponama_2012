class AddCommonAttributesToDeliveries < ActiveRecord::Migration
  def change
    [:mails].each do |table|
      add_column table, :available, :boolean, :default => true
      add_column table, :sequence, :integer
      add_column table, :name, :string
      add_column table, :delivery_cost, :decimal, :default => 0, :precision => 8, :scale => 2
      add_column table, :delivery_id, :integer
      add_column table, :content, :text
      add_column table, :postal_address_required, :boolean, :default => false
      add_column table, :full_prepayment_required, :boolean, :default => false
      add_column table, :passport_required, :boolean, :default => false


      add_index table, :delivery_id, name: "index_#{table}_on_delivery_id"
    end
  end
end
