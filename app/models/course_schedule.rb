class CourseSchedule < ActiveRecord::Base
  belongs_to :research_group

  validates :seq,inclusion: { in: 1..99,
                            message: "序号须为正整数" }
  validates :number_of_courses,inclusion: { in: 1..9999,
                              message: "疗程数须为正整数" }
  validates :cure_span,inclusion: { in: 1..9999,
                              message: "疗程天数须为正整数" }
  validates :rest_span,inclusion: { in: 0..9999,
                              message: "休息天数须为整数" }

end
