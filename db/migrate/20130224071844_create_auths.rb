class CreateAuths < ActiveRecord::Migration
  def change
    create_table :auths do |t|
      t.string :provider
      t.string :uid
      t.references :user, index: true
      t.text :data

      t.timestamps
    end
  end
end
