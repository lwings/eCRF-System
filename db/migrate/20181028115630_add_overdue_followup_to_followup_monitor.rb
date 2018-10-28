class AddOverdueFollowupToFollowupMonitor < ActiveRecord::Migration
  def change
    add_column :followup_monitors, :overdue_followup, :integer
  end
end
