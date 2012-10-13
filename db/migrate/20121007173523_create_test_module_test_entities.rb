class CreateTestModuleTestEntities < ActiveRecord::Migration
  def change
    create_table :test_module_test_entities do |t|

      t.timestamps
    end
  end
end
