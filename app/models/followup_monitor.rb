class FollowupMonitor < ActiveRecord::Base
  belongs_to :patient
  belongs_to :research_group
end
