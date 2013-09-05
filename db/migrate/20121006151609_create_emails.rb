class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :value
      t.references :profile, index: true

      t.timestamps
    end

  end
end
