class ClinicalPathology < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :primary_lesion, in: PRILESION_OPT
  enumerize :regional_lympth_node, in: LYMNODE_OPT
  enumerize :op_breast_mode, in: BREAST_MODE_OPT
  enumerize :histological_type, in: HISTYPE_OPT
  enumerize :histological_grading, in: HISGRAD_OPT
  enumerize :vascular_invasion, in: TRIPLET_OPT_I
  enumerize :HER2_IHC, in: HER2IHC_OPT
  enumerize :HER2_FISH, in:TRIPLET_OPT_II

  belongs_to :patient

  has_many :family_histories, dependent: :destroy
  has_many :history_of_nonbreast_cancers, dependent: :destroy

  # view
  accepts_nested_attributes_for :history_of_nonbreast_cancers,
                                reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :family_histories,
                                reject_if: :all_blank, allow_destroy: true

  validates_associated :family_histories
  validates_associated :history_of_nonbreast_cancers
  validates :patient_id,presence: true

end
