class CreateBasementAssessments < ActiveRecord::Migration
  def change
    create_table :basement_assessments do |t|
      t.belongs_to :patient, index:true
      t.float :height
      t.float :weight
      t.float :BMI
      t.float :systolic_blood_pressure
      t.float :diastolic_blood_pressure
      t.integer :physical_state_assessment

      t.date :pregnancy_test_date
      t.integer :pregnancy_test_result

      t.date :electrocardiogram_date
      t.integer :electrocarddiogram_diagnosis
      t.text :electrocarddiogram_description

      t.date :breast_B_ultrasound_date
      t.integer :breast_B_ultrasound_date_diagnosis
      t.text :breast_B_ultrasound_date_description

      t.date :Mammography_date
      t.integer :Mammography_diagnosis
      t.text :Mammography_description

      t.date :abdominal_B_ultrasound_date
      t.integer :abdominal_B_ultrasound_date_diagnosis
      t.text :abdominal_B_ultrasound_date_description

      t.date :breast_CT_date
      t.integer :breast_CT_diagnosis
      t.text :breast_CT_description

      t.date :echocardiography_date
      t.float :LVEF
      t.integer :echocardiography_diagnosis
      t.text :echocardiography_description

      t.timestamps null: false
    end
  end
end
