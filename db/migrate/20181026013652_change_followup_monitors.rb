class ChangeFollowupMonitors < ActiveRecord::Migration
  def change
    remove_column :followup_monitors, :if_under_followup , :boolean
    add_column :followup_monitors,:base_followup_days, :integer ,default: 0
    remove_column :followup_monitors, :day_seq , :integer
    add_column :followup_monitors,:start_date, :date
    add_column :followup_monitors,:last_followup_date, :date
    add_column :followup_monitors,:base_interval, :integer
    add_column :research_groups,:base_interval, :integer
  end

end
