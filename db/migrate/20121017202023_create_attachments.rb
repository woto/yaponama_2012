class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.references :email
      t.string :attachment

      t.timestamps
    end
    add_index :attachments, :email_id
  end
end
