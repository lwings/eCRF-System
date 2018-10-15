class MedicationCompletion < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :physical_examination, in: TWOTUPLE_OPT
  enumerize :breast_Bultra_diagnose, in: DIAGNOSE_OPT
  enumerize :abdo_Bultra_diagnose, in: DIAGNOSE_OPT

end
