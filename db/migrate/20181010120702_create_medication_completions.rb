class CreateMedicationCompletions < ActiveRecord::Migration
  def change
    create_table :medication_completions do |t|
      t.belongs_to :patient, index:true
      t.date :visit_date
      t.float :height
      t.float :weight
      t.integer :ECOG
      t.integer :physical_examination
      t.text :description
      t.boolean :if_followup

      t.date :breast_Bultra_date
      t.integer :breast_Bultra_diagnose
      t.string :breast_abnormal

      t.date :abdo_Bultra_date
      t.integer :abdo_Bultra_diagnose
      t.string :abdo_abnormalt


      t.timestamps null: false
    end
  end
end
