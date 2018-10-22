class MoveBaseFollowupDaysToResearchGroup < ActiveRecord::Migration
  def change
    remove_column :patients,:followup_left, :integer
    add_column :research_groups,:base_followup_days,:integer
  end
end
