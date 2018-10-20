class TumorMakerMed < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :name, in: TUMORNAME_OPT
  enumerize :unit, in: TUMORUNIT_OPT
  belongs_to :medication_completion

end
