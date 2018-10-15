class CreateTumorMakerMeds < ActiveRecord::Migration
  def change
    create_table :tumor_maker_meds do |t|
      t.belongs_to :medication_completion,index: true
      t.float :value
      t.date :sample_date
      t.boolean :is_local_hospital

      t.timestamps null: false
    end
  end
end
