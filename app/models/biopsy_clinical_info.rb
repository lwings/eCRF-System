class BiopsyClinicalInfo < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :biopsy_position, in: BIOPSY_POSITION_OPT
  enumerize :biopsy_mode, in: BIOPSY_MODE_OPT
  enumerize :histological_type, in: HISTYPE_OPT
  enumerize :histological_grading, in: HISGRAD_OPT
  enumerize :ER_strength, in: STRENGTH_OPT
  enumerize :PR_strength, in: STRENGTH_OPT
  enumerize :HER2_IHC, in: HER2IHC_OPT
  enumerize :HER2_FISH, in: TRIPLET_OPT_II
  enumerize :AR_strength, in: STRENGTH_OPT
  belongs_to :clinical_pathology

  # validates :biopsy_position, presence: true
  # validates :biopsy_position_remark, presence: true
  # validates :biopsy_date, presence: true
  # validates :biopsy_mode, presence: true
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
