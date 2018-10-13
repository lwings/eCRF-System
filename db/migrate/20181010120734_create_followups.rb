class CreateFollowups < ActiveRecord::Migration
  def change
    create_table :followups do |t|
      t.belongs_to :patient, index: true
      t.date :date_of_visit
      t.boolean :local_recurrence
      t.date :date_of_local_recurrence
      t.boolean :matastasis
      t.date :date_of_matastasis
      t.boolean :contralateral_breast_cancer
      t.date :date_of_contralateral_breast_cancer
      t.boolean :second_primary_cancer
      t.date :date_of_second_primary_cancer
      t.boolean :death
      t.date :date_of_death
      t.integer :cause_of_death

      t.timestamps null: false
    end
  end
end
