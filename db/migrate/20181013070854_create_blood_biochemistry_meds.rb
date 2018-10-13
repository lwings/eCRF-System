class CreateBloodBiochemistryMeds < ActiveRecord::Migration
  def change
    create_table :blood_biochemistry_meds do |t|
      t.belongs_to :medication_completion, index: true
      t.string :name, null: true
      t.float :value
      t.date :sample_date
      t.string :unit
      t.timestamps null: false
    end
  end
end
