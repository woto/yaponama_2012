class CreateBots < ActiveRecord::Migration

  def change

    create_table :bots do |t|
      t.string :title
      t.string :comment
      t.string :user_agent
      t.inet :inet
      t.boolean :phantom
      t.references :creator

      t.timestamps
    end

  end

end
