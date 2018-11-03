class ExperimentalMedication < ActiveRecord::Base

  belongs_to :project
  belongs_to :course_medication

  validates :name,presence: true
  validates :project_id,presence: true
end
