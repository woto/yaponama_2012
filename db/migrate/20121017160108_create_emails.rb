class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.text :from_addrs
      t.text :return_path
      t.text :from
      t.text :subject
      t.text :in_reply_to
      t.text :to_addrs
      t.text :html_part
      t.text :text_part
      t.text :user_id
      t.text :to
      t.binary :body
      t.text :cc_addrs
      t.text :bcc_addrs
      t.text :bcc
      t.text :cc
      t.text :resent_bcc
      t.text :resent_cc
      t.text :is_multipart
      t.text :parts_length
      t.text :date
      t.text :message_id
      t.text :name
      t.text :content_types
      t.text :classes

      t.timestamps
    end
  end
end
