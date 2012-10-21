class ChangeFieldsToLongTextInEmails < ActiveRecord::Migration
  def up
    change_column :emails, :body, :text, :limit => 4294967295
    change_column :emails, :html_part, :text, :limit => 4294967295
    change_column :emails, :text_part, :text, :limit => 4294967295
  end

  def down
    change_column :emails, :body, :text
    change_column :emails, :html_part
    change_column :emails, :text_part
  end
end
