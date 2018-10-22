class RemoveResearchModel < ActiveRecord::Migration
  def change
    remove_index :research_groups,:research_id
    remove_index :experimental_medications,:research_id
    remove_index :patients,:research_id
    remove_column :research_groups,:research_id
    remove_column :experimental_medications,:research_id
    remove_column :patients,:research_id

    # add_foreign_key :patients, :projects

    add_reference :research_groups, :project, index: true
    # add_foreign_key :research_groups, :projects

    add_reference :experimental_medications, :project, index: true
    # add_foreign_key :experimental_medications, :projects

  end
end
