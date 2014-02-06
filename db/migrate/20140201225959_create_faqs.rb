class CreateFaqs < ActiveRecord::Migration
  def change
    create_table :faqs do |t|
      t.text :question
      t.text :answer
      t.boolean :phantom, default: false

      t.timestamps
    end
  end
end
