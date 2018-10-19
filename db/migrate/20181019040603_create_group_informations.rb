class CreateGroupInformations < ActiveRecord::Migration
  def change
    create_table :group_informations do |t|
      t.belongs_to :patient, index: true
      t.belongs_to :research_group, index: true

      t.boolean :is_meet_inclusion_criteria
      t.date :inform_consent_date
      t.date :random_groping_date
      t.timestamps null: false
    end
  end
end
