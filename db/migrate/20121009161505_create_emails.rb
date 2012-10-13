class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :from_addrs
      t.string :return_path
      t.string :from
      t.string :subject
      t.string :in_reply_to
      t.string :to_addrs
      t.text :html_part
      t.text :text_part
      t.references :user

      t.timestamps
    end
  end
end
