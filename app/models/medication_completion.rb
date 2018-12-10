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


  validates_associated :blood_biochemistry_meds
  validates_associated :blood_routine_meds
  validates_associated :tumor_maker_meds
  validates :visit_date,presence: true


  after_create :convertStatusToFollowup
  after_create :initFollowupMonitor
  after_create :convertStatusToQuit

  def convertStatusToFollowup
    if self.if_followup
      self.patient.update(status:2)
    end
  end

  def convertStatusToQuit
    if self.if_followup==false
      self.patient.update(status:3)
    end
  end

  def initFollowupMonitor
    if self.if_followup
      if self.patient.followup_monitor==nil
        self.patient.create_followup_monitor()
      end
      self.patient.followup_monitor.update(base_followup_days:self.patient.group_information.research_group.base_followup_days,
                                           start_date:self.visit_date,
                                           base_interval:self.patient.group_information.research_group.base_interval,
                                           last_followup_date:self.visit_date,
                                           research_group_id:self.patient.group_information.research_group_id)
    end
  end

end
