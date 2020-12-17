class AddSumDiameterToTumorEvaluation < ActiveRecord::Migration
  def change
    add_column :tumor_evaluations, :sum_diameter, :float
  end
end
