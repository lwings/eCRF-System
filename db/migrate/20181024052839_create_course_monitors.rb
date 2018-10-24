class CreateCourseMonitors < ActiveRecord::Migration
  def change
    create_table :course_monitors do |t|
      t.belongs_to :patient, index: true
      t.belongs_to :research_group, index: true

      t.boolean :if_under_research, default: false


      t.integer :current_phase_seq, default: 0
      t.integer :current_course_seq, default: 0
      t.integer :current_day_seq, default: 0
      t.boolean :if_rest, default: false
      t.integer :current_rest_seq, default: 0

      t.integer :record_phase_seq, default: 0
      t.integer :record_course_seq, default: 0
      t.integer :record_day_seq, default: 0

      t.integer :course_diff, default: 0
      t.timestamps null: false
    end
  end
end
