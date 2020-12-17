class CreateNewLesions < ActiveRecord::Migration
  def change
    create_table :new_lesions do |t|
      t.string :position
      t.integer :inspection_method
      t.date :date
      t.references :tumor_evaluation, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
