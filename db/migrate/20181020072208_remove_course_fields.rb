class RemoveCourseFields < ActiveRecord::Migration
  def change
    remove_column :courses,:dose
    remove_column :courses,:date_of_administration
    remove_column :courses,:if_delay_administration
    remove_column :courses,:reason_for_delay
    remove_column :courses,:description_for_delay
    remove_column :courses,:if_change_dose
    remove_column :courses,:reason_for_change
    remove_column :courses,:description_for_change
  end
end
