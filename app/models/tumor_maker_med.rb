class TumorMakerMed < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :name, in: TUMORNAME_OPT
  enumerize :unit, in: TUMORUNIT_OPT
  belongs_to :medication_completion

  validates :medication_completion_id,presence: true
  validates :value,presence: true
  validates :sample_date,presence: true
  validates :name,presence: true
  validates :unit,presence: true

end
