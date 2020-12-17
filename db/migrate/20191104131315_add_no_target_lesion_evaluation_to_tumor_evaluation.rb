class AddNoTargetLesionEvaluationToTumorEvaluation < ActiveRecord::Migration
  def change
    add_column :tumor_evaluations, :no_target_lesion_evaluation, :integer
  end
end
