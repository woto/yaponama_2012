class RenameInvisibleToNotesInvisible < ActiveRecord::Migration
  def up
    rename_column :deliveries, :invisible, :notes_invisible
    change_column :deliveries, :notes_invisible, :text

    rename_column :email_addresses, :invisible, :notes_invisible
    change_column :email_addresses, :notes_invisible, :text

    rename_column :names, :invisible, :notes_invisible
    change_column :names, :notes_invisible, :text

    rename_column :phones, :invisible, :notes_invisible
    change_column :phones, :notes_invisible, :text

    rename_column :postal_addresses, :invisible, :notes_invisible
    change_column :postal_addresses, :notes_invisible, :text


    rename_column :products, :invisible, :notes_invisible
    change_column :products, :notes_invisible, :text

    rename_column :requests, :invisible, :notes_invisible
    change_column :requests, :notes_invisible, :text

    rename_column :users, :invisible, :notes_invisible
    change_column :users, :notes_invisible, :text

  end

  def down
  end
end
