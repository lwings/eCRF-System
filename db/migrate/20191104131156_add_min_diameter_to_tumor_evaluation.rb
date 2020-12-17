class AddMinDiameterToTumorEvaluation < ActiveRecord::Migration
  def change
    add_column :tumor_evaluations, :min_diameter, :float
  end
end
