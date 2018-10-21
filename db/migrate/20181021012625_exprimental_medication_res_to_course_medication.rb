class ExprimentalMedicationResToCourseMedication < ActiveRecord::Migration
  def change
    add_reference :course_medications, :experimental_medication, index: true
    add_foreign_key :course_medications, :experimental_medications
  end
end
