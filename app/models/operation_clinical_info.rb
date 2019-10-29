class OperationClinicalInfo < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :op_position, in: OP_POSITION_OPT
  enumerize :op_breast_mode, in: OP_BREAST_MODE_OPT
  enumerize :op_armpit_mode, in: OP_ARMPIT_MODE_OPT
  enumerize :histological_type, in: HISTYPE_OPT
  enumerize :histological_grading, in: HISGRAD_OPT
  enumerize :ER_strength, in: STRENGTH_OPT
  enumerize :PR_strength, in: STRENGTH_OPT
  enumerize :HER2_IHC, in: HER2IHC_OPT
  enumerize :HER2_FISH, in: TRIPLET_OPT_II
  enumerize :AR_strength, in: STRENGTH_OPT
  enumerize :regional_lympth_node, in: LYMNODE_OPT
  enumerize :primary_lesion, in: PRILESION_OPT
  belongs_to :clinical_pathology

  # validates :op_position, presence: true
  # validates :op_date, presence: true
  # validates :op_breast_mode, presence: true
  # validates :op_armpit_mode, presence: true
  # validates :tumor_size, presence: true
  # validates :lympth_matastasis_cnt, presence: true
  # validates :histological_type, presence: true
  # validates :histological_grading, presence: true
  # validates :ER, presence: true
  # validates :ER_strength, presence: true
  # validates :PR, presence: true
  # validates :PR_strength, presence: true
  # validates :HER2_IHC, presence: true
  # validates :HER2_FISH, presence: true
  # validates :Ki67, presence: true
  # validates :AR, presence: true
  # validates :AR_strength, presence: true
  # validates :comment, presence: true
end
