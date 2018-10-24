class CreateFollowupMonitors < ActiveRecord::Migration
  def change
    create_table :followup_monitors do |t|
      t.belongs_to :patient, index: true
      t.belongs_to :research_group, index: true

      t.boolean :if_under_followup, default: false
      t.integer :day_seq, default: 0

      t.timestamps null: false
    end
  end
end
