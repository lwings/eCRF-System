class CreateCenterProjectRelationships < ActiveRecord::Migration
  def change
    create_table :center_project_relationships do |t|
      t.belongs_to :project, index: true
      t.belongs_to :center, index: true
      t.integer :planned_patients_count,default: 0
      t.timestamps null: false
    end
  end
end
