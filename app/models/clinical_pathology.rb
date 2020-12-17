class ClinicalPathology < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :primary_lesion, in: PRILESION_OPT
  enumerize :regional_lympth_node, in: LYMNODE_OPT
  enumerize :op_breast_mode, in: OP_BREAST_MODE_OPT
  enumerize :op_armpit_mode, in: OP_ARMPIT_MODE_OPT
  enumerize :histological_type, in: HISTYPE_OPT
  enumerize :histological_grading, in: HISGRAD_OPT
  enumerize :vascular_invasion, in: TRIPLET_OPT_I
  enumerize :HER2_IHC, in: HER2IHC_OPT
  enumerize :HER2_FISH, in:TRIPLET_OPT_II

  belongs_to :patient

  has_many :family_histories, dependent: :destroy
  has_many :history_of_nonbreast_cancers, dependent: :destroy

  has_many :first_diagnosis_clinical_phases, dependent: :destroy
  has_many :biopsy_clinical_infos, dependent: :destroy
  has_many :operation_clinical_infos, dependent: :destroy

  # view

  accepts_nested_attributes_for :first_diagnosis_clinical_phases,
                                reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :biopsy_clinical_infos,
                                reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :operation_clinical_infos,
                                reject_if: :all_blank, allow_destroy: true

  accepts_nested_attributes_for :history_of_nonbreast_cancers,
                                reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :family_histories,
                                reject_if: :all_blank, allow_destroy: true

  validates_associated :first_diagnosis_clinical_phases
  validates_associated :biopsy_clinical_infos
  validates_associated :operation_clinical_infos

  validates_associated :family_histories
  validates_associated :history_of_nonbreast_cancers
  validates :patient_id,presence: true

end
