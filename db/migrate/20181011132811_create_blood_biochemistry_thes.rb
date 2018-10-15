class CreateBloodBiochemistryThes < ActiveRecord::Migration
  def change
    create_table :blood_biochemistry_thes do |t|
      t.belongs_to :course, index: true
      t.string :name, null: true
      t.float :value
      t.date :sample_date
      t.string :unit

      t.timestamps null: false
    end
  end
end
