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

      t.timestamps null: false
    end
  end
end
