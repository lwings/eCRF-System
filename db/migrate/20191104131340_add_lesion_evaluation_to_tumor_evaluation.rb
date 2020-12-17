class AddLesionEvaluationToTumorEvaluation < ActiveRecord::Migration
  def change
    add_column :tumor_evaluations, :lesion_evaluation, :integer
  end
end
