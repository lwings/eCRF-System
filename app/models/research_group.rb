class ResearchGroup < ActiveRecord::Base

  belongs_to :project
  has_many :course_schedules

  # view
  accepts_nested_attributes_for :course_schedules,
                                reject_if: :all_blank, allow_destroy: true

end
