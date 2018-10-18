class AddProjectRefToResearch < ActiveRecord::Migration
  def change
    add_reference :researches, :project, index: true
    add_foreign_key :researches, :projects
  end
end
