class FamilyHistory < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :procession_of_disease, in: DIEASEPROCESSION_OPT

  belongs_to :clinical_pathology


  validates :relation_with_patient,presence: true
  validates :procession_of_disease,presence: true

end
