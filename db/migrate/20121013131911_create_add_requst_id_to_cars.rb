class CreateAddRequstIdToCars < ActiveRecord::Migration
  def change
    create_table :add_requst_id_to_cars do |t|
      t.references :request

      t.timestamps
    end
    add_index :add_requst_id_to_cars, :request_id
  end
end
