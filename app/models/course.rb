class Course < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :reason_for_delay, in: DELAY_OPT
  enumerize :reason_for_change, in: DOSECHANGE_OPT

  belongs_to :patient

  has_many :blood_biochemistry_thes, dependent: :destroy
  has_many :blood_routine_thes, dependent: :destroy

end
