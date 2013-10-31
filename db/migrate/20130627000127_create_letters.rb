class CreateLetters < ActiveRecord::Migration
  def change
    create_table :letters do |t|
      t.references :somebody, index: true
      t.references :email, index: true
      t.text :subject
      t.binary :source
      t.string :charset
      t.text :size
      t.string :letter
      t.text :letter_type

      t.timestamps
    end
  end
end
