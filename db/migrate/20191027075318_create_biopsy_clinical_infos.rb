class CreateBiopsyClinicalInfos < ActiveRecord::Migration
  def change
    create_table :biopsy_clinical_infos do |t|
      t.references :clinical_pathology, index: true, foreign_key: true
      t.integer :biopsy_position
      t.string :biopsy_position_remark
      t.date :biopsy_date
      t.integer :biopsy_mode
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
