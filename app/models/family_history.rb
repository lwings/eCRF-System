class FamilyHistory < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :procession_of_disease, in: DIEASEPROCESSION_OPT

  belongs_to :clinical_pathology

end
