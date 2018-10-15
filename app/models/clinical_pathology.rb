class ClinicalPathology < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :primary_lesion, in: PRILESION_OPT
  enumerize :reginoal_lympth_node, in: LYMNODE_OPT
  enumerize :histological_type, in: HISTYPE_OPT
  enumerize :histological_grading, in: HISGRAD_OPT
  enumerize :vascular_invasion, in: TRIPLET_OPT_I
  enumerize :HER2_IHC, in: HER2IHC_OPT
  enumerize :HER2_FISH, in:TRIPLET_OPT_II

end
