class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.references :email, index: true
      t.string :attachment

      t.timestamps
    end
  end
end
