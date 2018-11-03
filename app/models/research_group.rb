class ResearchGroup < ActiveRecord::Base

  belongs_to :project
  has_many :course_schedules
  has_many :course_monitors
  has_many :followup_monitors

  before_save :set_total_courses
  after_save :setLastScheduleRestSpan

  # view
  accepts_nested_attributes_for :course_schedules,
                                reject_if: :all_blank, allow_destroy: true

  attr_accessor :project_name
  attr_accessor :courses_schedules_count


  validates_associated :course_schedules
  validates :name, presence: true
  validates :base_followup_days, presence: true,inclusion: { in: 1..9999,
                                                             message: "额定随访天数须为正整数" }
  validates :base_interval, presence: true,inclusion: { in: 1..9999,
                                                        message: "额定随访间隔须为正整数" }
  validates :project_id, presence: true

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

  def getCourseScheduleChart
    chart=[[]]
    self.course_schedules.order("seq").each_with_index { |cs, index|
      chart[index]=[cs.number_of_courses,cs.cure_span,cs.rest_span]
    }
    chart
  end

  private
  def set_total_courses
    res=0

    self.course_schedules.each{|cs|
      res+= cs.number_of_courses
    }
    self.total_courses=res
  end
  def setLastScheduleRestSpan
    # debugger
    self.course_schedules.all.last.update(rest_span:0)
  end

end
