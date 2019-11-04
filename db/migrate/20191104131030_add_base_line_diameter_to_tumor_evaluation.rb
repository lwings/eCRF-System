class AddBaseLineDiameterToTumorEvaluation < ActiveRecord::Migration
  def change
    add_column :tumor_evaluations, :base_line_diameter, :float
  end
end
