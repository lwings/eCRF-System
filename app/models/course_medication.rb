class CourseMedication < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :reason_for_delay, in: DELAY_OPT
  enumerize :reason_for_change, in: DOSECHANGE_OPT

  belongs_to :course

  has_many :experimental_medications

  validates :experimental_medication_id, presence: true
  # validates :course_id, presence: true
  validates :dose, presence: true

end
