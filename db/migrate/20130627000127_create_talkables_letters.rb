class CreateTalkablesLetters < ActiveRecord::Migration
  def change
    create_table :talkables_letters do |t|
      t.references :email, index: true
      t.text :subject
      t.text :size
      t.string :letter

      t.timestamps
    end
  end
end
