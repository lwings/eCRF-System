class BloodRoutine < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :name, in: BLOODRNAME_OPT
  enumerize :unit, in: BLOODRUNIT_OPT

  belongs_to :basement_assessment

  validates :basement_assessment_id,presence: true
  validates :name,presence: true
  validates :value,presence: true
  validates :sample_date,presence: true

end
