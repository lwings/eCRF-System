class CreateBloodRoutineThes < ActiveRecord::Migration
  def change
    create_table :blood_routine_after_thes do |t|
      t.belongs_to :course, index: true
      t.string :name,null: true
      t.float :value
      t.date :sample_date
      t.string :unit

      t.timestamps null: false
    end
  end
end
