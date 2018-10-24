class ResearchGroup < ActiveRecord::Base

  belongs_to :project
  has_many :course_schedules
  has_many :course_monitors
  has_many :followup_monitors


  # view
  accepts_nested_attributes_for :course_schedules,
                                reject_if: :all_blank, allow_destroy: true

  attr_accessor :project_name
  attr_accessor :courses_schedules_count



  def set_project_name_count
    self.project_name=self.project.name
  end

  def set_courses_schedules_count
    self.courses_schedules_count=self.course_schedules.size
  end

  def set_all_count
    self.set_courses_schedules_count
    self.set_project_name_count
  end
end
