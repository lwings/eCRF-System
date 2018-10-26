class FollowupMonitor < ActiveRecord::Base
  require 'date'
  belongs_to :patient
  belongs_to :research_group

  def updateMonitorByDay
    if self.patient.status !=3
      return
    end
    if days_till_now(self.start_date)>=self.base_followup_days
      self.patient.update(status:4)
    end
  end

  private

  def days_till_now(date)
    date=date.strftime("%Y-%m-%d")
    d1 = Date.parse(date)
    d2 = Date.parse(Time.now.strftime("%Y-%m-%d"))
    (d2 - d1).to_i
  end
end
