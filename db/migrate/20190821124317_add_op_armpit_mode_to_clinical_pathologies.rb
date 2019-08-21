class AddOpArmpitModeToClinicalPathologies < ActiveRecord::Migration
  def change
    add_column :clinical_pathologies, :op_armpit_mode, :integer
  end
end
