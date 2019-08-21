class AddOpBreastModeToClinicalPathologies < ActiveRecord::Migration
  def change
    add_column :clinical_pathologies, :op_breast_mode, :integer
  end
end
