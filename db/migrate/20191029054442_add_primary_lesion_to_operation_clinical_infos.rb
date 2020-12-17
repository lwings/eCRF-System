class AddPrimaryLesionToOperationClinicalInfos < ActiveRecord::Migration
  def change
    add_column :operation_clinical_infos, :primary_lesion, :integer
  end
end
