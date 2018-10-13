class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.belongs_to :patient, index: true
      t.belongs_to :experimental_medication, index:true
      t.date :interview
      t.float :height
      t.float :weight
      t.float :body_surface_area

      t.integer :drugs
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
