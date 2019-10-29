class ChangeMatastasisToBeIntegerInFirstDiagnosisClinicalPhase < ActiveRecord::Migration
  def change
    change_column :first_diagnosis_clinical_phases, :matastasis, :integer
  end
end
