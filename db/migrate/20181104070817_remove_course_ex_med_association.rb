class RemoveCourseExMedAssociation < ActiveRecord::Migration
  def change
    remove_index :courses,:experimental_medication_id
    remove_column :courses,:experimental_medication_id
  end
end
