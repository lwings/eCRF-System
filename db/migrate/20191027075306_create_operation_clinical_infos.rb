class CreateOperationClinicalInfos < ActiveRecord::Migration
  def change
    create_table :operation_clinical_infos do |t|
      t.references :clinical_pathology, index: true, foreign_key: true
      t.integer :op_position
      t.date :op_date
      t.integer :op_breast_mode
      t.integer :op_armpit_mode
      t.float :tumor_size
      t.integer :lympth_matastasis_cnt
      t.integer :histological_type
      t.integer :histological_grading
      t.integer :ER
      t.integer :ER_strength
      t.integer :PR
      t.integer :PR_strength
      t.integer :HER2_IHC
      t.integer :HER2_FISH
      t.integer :Ki67
      t.integer :AR
      t.integer :AR_strength
      t.string :comment

      t.timestamps null: false
    end
  end
end
