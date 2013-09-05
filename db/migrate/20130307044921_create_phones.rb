class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :value
      t.boolean :mobile
      #t.string :phone_type
      t.references :profile, index: true

      t.timestamps
    end
  end
end
