class BloodRoutineMed < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :name, in: BLOODRNAME_OPT
  enumerize :unit, in: BLOODRUNIT_OPT
  belongs_to :medication_completion

  validates :medication_completion_id,presence: true
  validates :name,presence: true
  validates :value,presence: true
  validates :sample_date,presence: true

end
