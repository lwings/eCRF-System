class BasementAssessment < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :pregnancy_test_result, in:TRIPLET_OPT_II
  enumerize :electrocarddiogram_diagnosis, in:DIAGNOSE_OPT

  belongs_to :patient

  has_many :blood_biochemistries, dependent: :destroy
  has_many :blood_routines, dependent: :destroy

  validates_presence_of :patient

  # view
  accepts_nested_attributes_for :blood_routines,
                                reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :blood_biochemistries,
                                reject_if: :all_blank, allow_destroy: true

end
