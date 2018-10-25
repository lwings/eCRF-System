class ChangeCourceMonitors < ActiveRecord::Migration
  def change
    add_column :research_groups, :total_courses, :integer
  end
end
