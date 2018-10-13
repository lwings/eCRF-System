class CreateExperimentalMedications < ActiveRecord::Migration
  def change
    create_table :experimental_medications do |t|
      t.belongs_to :research, index: true
      t.string :name, null:false
      t.string :remark

      t.timestamps null: false
    end
  end
end
