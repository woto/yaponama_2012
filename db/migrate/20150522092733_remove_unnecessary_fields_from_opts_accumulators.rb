class RemoveUnnecessaryFieldsFromOptsAccumulators < ActiveRecord::Migration
  def change
    remove_column :opts_accumulators, :case_size, :integer
    remove_column :opts_accumulators, :weight_filled, :integer
  end
end
