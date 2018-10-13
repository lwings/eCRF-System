class CreateReserachCompletions < ActiveRecord::Migration
  def change
    create_table :reserach_completions do |t|
      t.belongs_to :patient, index: true
      t.date :date_of_last_confirmation
      t.boolean :if_complete_therapy_according_to_plan
      t.integer :reason_for_early_quit
      t.text :description
      t.timestamps null: false
    end
  end
end
