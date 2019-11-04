class AddCmpBaseLineDiameterToTumorEvaluation < ActiveRecord::Migration
  def change
    add_column :tumor_evaluations, :cmp_base_line_diameter, :float
  end
end
