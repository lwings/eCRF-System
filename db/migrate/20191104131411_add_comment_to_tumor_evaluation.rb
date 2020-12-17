class AddCommentToTumorEvaluation < ActiveRecord::Migration
  def change
    add_column :tumor_evaluations, :comment, :string
  end
end
