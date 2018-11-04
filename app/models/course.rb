class Course < ActiveRecord::Base
  extend Enumerize
  include Constant

  belongs_to :patient

  has_many :course_medications,dependent: :destroy
  has_many :blood_biochemistry_thes, dependent: :destroy
  has_many :blood_routine_thes, dependent: :destroy

  accepts_nested_attributes_for :blood_routine_thes,
                                reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :blood_biochemistry_thes,
                                reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :course_medications,
                                reject_if: :all_blank, allow_destroy: true


  after_create :convertStatusToResearching
  after_create :setCourseMonitor
  before_destroy :rollBackMonitor

  validates :patient_id, presence: true
  validates :interview, presence: true


  def setCourseMonitor
    numOfCourses=self.patient.courses.size()
    self.patient.course_monitor.setRecord numOfCourses , self.interview
  end

  def rollBackMonitor
    if self.patient.courses.size() >0
      numOfCourses=self.patient.courses.size()
      self.patient.course_monitor.setRecord numOfCourses-1 , self.patient.courses.last(2).first.interview
    end
  end

  def convertStatusToResearching
      self.patient.update(status:1)
  end

end
