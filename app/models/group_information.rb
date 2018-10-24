class GroupInformation < ActiveRecord::Base
  belongs_to :patient
  belongs_to :research_group

  after_save :set_course_monitor
  after_save :set_followup_monitor


  private
  def set_course_monitor
    if self.patient.course_monitor.nil?
      self.patient.course_monitor.create(research_group_id:self.research_group_id)
    else
      self.patient.course_monitor.delete
      self.patient.course_monitor.create(research_group_id:self.research_group_id)
    end
  end

  def set_followup_monitor
    if self.patient.followup_monitor.nil?
      self.patient.followup_monitor.create(research_group_id:self.research_group_id)
    else
      self.patient.followup_monitor.delete
      self.patient.followup_monitor.create(research_group_id:self.research_group_id)
    end
  end

end
