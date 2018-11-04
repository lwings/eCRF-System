class RemovePatientResearchGroupAssociation < ActiveRecord::Migration
  def change
    remove_index :patients,:research_group_id
    remove_column :patients,:research_group_id
  end
end
