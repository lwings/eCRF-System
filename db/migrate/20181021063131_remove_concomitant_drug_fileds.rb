class RemoveConcomitantDrugFileds < ActiveRecord::Migration
  def change
    remove_column :concomitant_drugs, :if_concomitant,:boolean
    remove_column :biological_sample_collections, :interview,:integer
    remove_column :biological_sample_collections, :if_sample,:boolean
  end
end