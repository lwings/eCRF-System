class CreateConcomitantDrugs < ActiveRecord::Migration
  def change
    create_table :concomitant_drugs do |t|
      t.belongs_to :patient, index: true
      t.boolean :if_concomitant
      t.string :drugs
      t.string :cause_for_this_drug
      t.float :daily_dose
      t.string :unit_of_dose
      t.date :start_date
      t.date :end_date

      t.timestamps null: false
    end
  end
end
