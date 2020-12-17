class CreateNoTargetLesions < ActiveRecord::Migration
  def change
    create_table :no_target_lesions do |t|
      t.string :position
      t.integer :inspection_method
      t.boolean :is_exist
      t.references :tumor_evaluation, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
