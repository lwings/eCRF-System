class Followup < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :cause_of_death, in:DEATH_OPT

  belongs_to :patient


  after_create :set_followup_monitor
  before_destroy :roll_backMonitor

  def set_followup_monitor
    if self.id==self.patient.followups.last.id
      self.patient.followup_monitor.update(last_followup_date:self.date_of_visit)
    end

  end

  def roll_backMonitor
    if self.patient.followups.size() >1
      self.patient.followup_monitor.update(last_followup_date:self.patient.followups.last(2).first.date_of_visit)
    end
  end
end
