class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.integer :status, default: 0
      t.belongs_to :project, index: true
      t.belongs_to :user, index: true
      t.belongs_to :research, index: true
      t.belongs_to :research_group, index:true

      t.integer :followup_left

      t.string :name, null:false
      t.string :pid
      t.string :hosptalization_number
      t.date :date_of_birth
      t.string :ID_number
      t.string :phone_number_1
      t.string :phone_number_2
      t.boolean :is_meet_inclusion_criteria
      t.date :inform_consent_date
      t.date :random_groping_date


      t.timestamps null: false
    end
  end
end
