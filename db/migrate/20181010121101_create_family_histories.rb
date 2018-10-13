class CreateFamilyHistories < ActiveRecord::Migration
  def change
    create_table :family_histories do |t|
      t.belongs_to :clinical_pathology, index: true
      t.string :relation_with_patient
      t.integer :age_at_diagnose
      t.string :treatment
      t.integer :procession_of_disease

      t.timestamps null: false
    end
  end
end
