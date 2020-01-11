class CreateResearchMonitors < ActiveRecord::Migration
  def change
    create_table :research_monitors do |t|

      t.timestamps null: false
    end
  end
end
