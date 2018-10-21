class ExperimentalMedication < ActiveRecord::Base

  belongs_to :research
  belongs_to :course_medication
end
