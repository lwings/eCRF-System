class AddRegionalLympthNodeToOperationClinicalInfos < ActiveRecord::Migration
  def change
    add_column :operation_clinical_infos, :regional_lympth_node, :integer
  end
end
