class FollowupMonitor < ActiveRecord::Base
  require 'date'
  belongs_to :patient
  belongs_to :research_group

  before_save :update_overdue_followup

  def check_if_terminate
    if self.patient.status.value !=2
      return
    end
    if days_till_now(self.start_date)>=self.base_followup_days
      self.patient.update(status:3)
    end
  end

  def update_overdue_followup
    if self.patient.status.value !=2
      return
    end
    self.base_followup_days=self.research_group.base_interval
    if self.base_followup_days==0
      self.base_followup_days=30
    end
    self.overdue_followup=days_till_now(self.last_followup_date)/self.base_followup_days
  end

  private

  def days_till_now(date)
    date=date.strftime("%Y-%m-%d")
    d1 = Date.parse(date)
    d2 = Date.parse(Time.now.strftime("%Y-%m-%d"))
    (d2 - d1).to_i
  end
end
