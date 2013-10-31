class CreateLetterParts < ActiveRecord::Migration
  def change
    create_table :letter_parts do |t|
      t.references :letter, index: true
      t.text :cid
      t.string :letter_part
      t.text :letter_part_type
      t.integer :is_attachment
      t.text :filename
      t.text :charset
      t.binary :body
      t.integer :size

      t.timestamps
    end
  end
end
