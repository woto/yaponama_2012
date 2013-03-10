class CreateCalls < ActiveRecord::Migration
  def change
    create_table :calls do |t|
      t.references :phone, index: true
      t.string :file

      t.timestamps
    end
  end
end
