class CreateMails < ActiveRecord::Migration
  def change
    create_table :mails do |t|

      t.timestamps
    end
  end
end
