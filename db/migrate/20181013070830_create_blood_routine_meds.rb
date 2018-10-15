class CreateBloodRoutineMeds < ActiveRecord::Migration
  def change
    create_table :blood_routine_meds do |t|
      t.belongs_to :medication_completion, index: true
      t.string :name,null: true
      t.float :value
      t.date :sample_date
      t.string :unit

      t.timestamps null: false
    end
  end
end
