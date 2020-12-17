class CreateTargetLesions < ActiveRecord::Migration
  def change
    create_table :target_lesions do |t|
      t.string :position
      t.integer :inspection_method
      t.float :max_diameter
      t.references :tumor_evaluation, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
