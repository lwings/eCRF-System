class RemovePatientFields < ActiveRecord::Migration
  def change
    # remove_foreign_key :patients, :research_group
    remove_column :patients, :is_meet_inclusion_criteria
    remove_column :patients, :inform_consent_date
    remove_column :patients, :random_groping_date
  end
end
