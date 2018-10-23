class AddSeqToCourseSchedules < ActiveRecord::Migration
  def change
    add_column :course_schedules,:seq, :integer,null: false
  end
end
