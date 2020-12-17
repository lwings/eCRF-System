class AddTargetLesionEvaluationToTumorEvaluation < ActiveRecord::Migration
  def change
    add_column :tumor_evaluations, :target_lesion_evaluation, :integer
  end
end
