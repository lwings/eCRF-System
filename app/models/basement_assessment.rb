class BasementAssessment < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :pregnancy_test_result, in:TRIPLET_OPT_II
  enumerize :electrocarddiogram_diagnosis, in:DIAGNOSE_OPT
  enumerize :breast_B_ultrasound_date_diagnosis, in:DIAGNOSE_OPT
  enumerize :Mammography_diagnosis, in:DIAGNOSE_OPT
  enumerize :abdominal_B_ultrasound_date_diagnosis, in:DIAGNOSE_OPT
  enumerize :breast_CT_diagnosis, in:DIAGNOSE_OPT
  enumerize :echocardiography_diagnosis, in:DIAGNOSE_OPT


  belongs_to :patient

  has_many :blood_biochemistries, dependent: :destroy
  has_many :blood_routines, dependent: :destroy

  validates_presence_of :patient
  validates :weight, inclusion: { :in => -1..150 }
  validates :height, inclusion: { :in => -1..2.2 }
  validates_associated :blood_biochemistries
  validates_associated :blood_routines

  # view
  accepts_nested_attributes_for :blood_routines,
                                reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :blood_biochemistries,
                                reject_if: :all_blank, allow_destroy: true

  before_save :set_BMI

  def set_BMI
    ( self.BMI = (weight / (height * height)).round(2) ) unless height.nil? || weight.nil? || weight == 0 || height == 0
  end
end
