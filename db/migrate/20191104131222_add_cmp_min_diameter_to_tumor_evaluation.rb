class AddCmpMinDiameterToTumorEvaluation < ActiveRecord::Migration
  def change
    add_column :tumor_evaluations, :cmp_min_diameter, :float
  end
end
