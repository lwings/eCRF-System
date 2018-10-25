class ChangeCourceMonitors < ActiveRecord::Migration
  def change
    remove_column :course_monitors, :record_day_seq, :integer
    add_column :course_monitors, :start_date, :date
    add_column :research_groups, :total_courses, :integer
  end
end
