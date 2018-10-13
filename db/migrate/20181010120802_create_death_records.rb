class CreateDeathRecords < ActiveRecord::Migration
  def change
    create_table :death_records do |t|
      t.belongs_to :patient, index:true
      t.date :date_of_death
      t.integer :cause_of_death
      t.integer :relation_with_medication

      t.timestamps null: false
    end
  end
end
