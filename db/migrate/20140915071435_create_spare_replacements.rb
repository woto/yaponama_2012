class CreateSpareReplacements < ActiveRecord::Migration
  def change
    create_table :spare_replacements do |t|
      t.references :from_spare_info, index: true
      t.references :to_spare_info, index: true
      t.string :from_cached_spare_info
      t.string :to_cached_spare_info
      t.string :comment
      t.string :source
      t.boolean :wrong

      t.timestamps
    end
  end
end
