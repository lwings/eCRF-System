class MedicationCompletion < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :physical_examination, in: TWOTUPLE_OPT
  enumerize :breast_Bultra_diagnose, in: DIAGNOSE_OPT
  enumerize :abdo_Bultra_diagnose, in: DIAGNOSE_OPT

  belongs_to :patient

  has_many :blood_biochemistry_meds, dependent: :destroy
  has_many :blood_routine_meds, dependent: :destroy
  has_many :tumor_maker_meds, dependent: :destroy

  accepts_nested_attributes_for :blood_routine_meds,
                                reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :blood_biochemistry_meds,
                                reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :tumor_maker_meds,
                                reject_if: :all_blank, allow_destroy: true

end
