class BloodBiochemistryMed < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :name, in: BLOODCNAME_OPT
  enumerize :unit, in: BLOODCUNIT_OPT

  belongs_to :medication_completion

  validates :medication_completion_id,presence: true
  validates :name,presence: true
  validates :value,presence: true
  validates :sample_date,presence: true

end
