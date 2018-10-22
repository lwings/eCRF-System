class CreateCourseSchedules < ActiveRecord::Migration
  def change
    create_table :course_schedules do |t|
      t.belongs_to :research_group, index: true

      t.integer :number_of_courses
      t.integer :cure_span
      t.integer :rest_span

      t.timestamps null: false
    end
  end
end
