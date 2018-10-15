class CreateClinicalPathologies < ActiveRecord::Migration
  def change
    create_table :clinical_pathologies do |t|
      t.belongs_to :patient, index: true
      t.integer :primary_lesion
      t.integer :regional_lympth_node
      t.boolean :matastasis
      t.integer :histological_type
      t.integer :histological_grading
      t.integer :vascular_invasion
      t.float :ER
      t.float :PR
      t.float :HER2_IHC
      t.float :HER2_FISH
      t.float :Ki67
      t.float :AR
      t.date :date_of_operation

      t.timestamps null: false
    end
  end
end
