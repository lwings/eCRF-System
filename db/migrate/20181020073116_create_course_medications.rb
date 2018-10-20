class CreateCourseMedications < ActiveRecord::Migration
  def change
    create_table :course_medications do |t|
      t.belongs_to :course,index: true

      t.float :dose
      t.date :date_of_administration
      t.boolean :if_delay_administration
      t.integer :reason_for_delay
      t.text :description_for_delay

      t.boolean :if_change_dose
      t.integer :reason_for_change
      t.text :description_for_change
      t.timestamps null: false
    end
  end
end
