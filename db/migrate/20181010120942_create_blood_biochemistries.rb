class CreateBloodBiochemistries < ActiveRecord::Migration
  def change
    create_table :blood_biochemistries do |t|
      t.belongs_to :basement_assessment, index: true
      t.string :name, null: true
      t.float :value
      t.date :sample_date
      t.string :unit

      t.timestamps null: false
    end
  end
end
