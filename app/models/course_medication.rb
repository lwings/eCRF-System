class CourseMedication < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :reason_for_delay, in: DELAY_OPT
  enumerize :reason_for_change, in: DOSECHANGE_OPT

  belongs_to :course
end
