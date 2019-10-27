class FirstDiagnosisClinicalPhase < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :primary_lesion, in: PRILESION_OPT
  enumerize :regional_lympth_node, in: LYMNODE_OPT
  belongs_to :clinical_pathology

  # validates :primary_lesion, presence: true
  # validates :regional_lympth_node, presence: true
  # validates :matastasis,presence: true
end
