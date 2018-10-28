class Patient < ActiveRecord::Base
  extend Enumerize

  enumerize :status,
            in: {
                established:  0,
                researching:  1,
                followup:  2,
                followup_end:3,
                quit:4
            },
            predicates: true,
            scope: true

  belongs_to :project
  belongs_to :user
  belongs_to :center
  has_one :basement_assessment, dependent: :destroy
  has_one :clinical_pathology, dependent: :destroy
  has_one :reserach_completion, dependent: :destroy
  has_one :medication_completion, dependent: :destroy
  has_one :group_information, dependent: :destroy
  has_one :death_record, dependent: :destroy
  has_one :course_monitor, dependent: :destroy
  has_one :followup_monitor, dependent: :destroy
  has_many :adverse_events, dependent: :destroy
  has_many :courses, dependent: :destroy
  has_many :radiation_therapies, dependent: :destroy
  has_many :concomitant_drugs, dependent: :destroy
  has_many :biological_sample_collections, dependent: :destroy
  has_many :followups, dependent: :destroy

  attr_accessor :center_name
  attr_accessor :overdue_courses
  attr_accessor :overdue_followups

  before_create :convertStatusToEstablished

  def convertStatusToEstablished
    self.status=0
  end

  def set_center_name
    self.center_name=self.center.name
  end

  def set_overdue_courses
    if self.status.value==1
      self.overdue_courses=self.course_monitor.overdue_course
    else
      self.overdue_courses="未干预"
    end
  end

  def set_overdue_followups
    if self.status.value==2
      self.overdue_followups=self.followup_monitor.overdue_followup
    else
      self.overdue_followups="未随访"
    end
  end

end
