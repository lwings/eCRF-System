class CreateFirstDiagnosisClinicalPhases < ActiveRecord::Migration
  def change
    create_table :first_diagnosis_clinical_phases do |t|
      t.references :clinical_pathology, index: true, foreign_key: true
      t.integer :primary_lesion
      t.integer :regional_lympth_node
      t.boolean :matastasis

      t.timestamps null: false
    end
  end
end
