class Followup < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :cause_of_death, in:DEATH_OPT

  belongs_to :patient


  after_create :setFollowupMonitor
  before_destroy :rollBackMonitor

  def setFollowupMonitor
    if self.id==self.patient.followups.last.id
      self.patient.followup_monitor.update(last_followup_date:self.date_of_visit)
    end

  end

  def rollBackMonitor
    if self.patient.followups.size() >1
      self.patient.followup_monitor.update(self.patient.followups.last(2).first.date_of_visit)
    end
  end
end
