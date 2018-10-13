class CreateRadiationTherapies < ActiveRecord::Migration
  def change
    create_table :radiation_therapies do |t|
      t.belongs_to :patient, index: true
      t.boolean :is_radiation
      t.integer :radiotherapy_site
      t.integer :therapy_type
      t.float :radiotherapy_dose

      t.date :radiotherapy_start_date
      t.date :radiotherapy_end_date

      t.timestamps null: false
    end
  end
end
