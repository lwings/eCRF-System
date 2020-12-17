class CreateTumorEvaluations < ActiveRecord::Migration
  def change
    create_table :tumor_evaluations do |t|
      t.date :date
      t.integer :interview
      t.references :patient, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
