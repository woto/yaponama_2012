class CreateNames < ActiveRecord::Migration
  def change
    create_table :names do |t|
      t.string :name
      t.string :creation_reason
      t.string :invisible
      t.references :user

      t.timestamps
    end
  end
end
