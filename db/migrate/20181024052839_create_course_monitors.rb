class CreateCourseMonitors < ActiveRecord::Migration
  def change
    create_table :course_monitors do |t|
      t.belongs_to :patient, index: true
      t.belongs_to :research_group, index: true


      t.integer :record_phase_seq, default: 0
      t.integer :record_course_seq, default: 0

      t.integer :overdue_course,default: 0
      t.date :last_record_date

      t.timestamps null: false
    end
  end
end
