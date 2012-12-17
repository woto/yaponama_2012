class CreateNames < ActiveRecord::Migration
  def change
    create_table :names do |t|
      t.string :name
      t.string :creation_reason
      t.string :invisible
      t.integer :user_id
      t.integer :creator_id
      # TODO аналогично как и в каком-то другом месте, позже разобраться с необходимостью этого поля
      t.boolean :visible, :default => true

      t.timestamps
    end
  end
end
