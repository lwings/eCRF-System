class CreateBiologicalSampleCollections < ActiveRecord::Migration
  def change
    create_table :biological_sample_collections do |t|
      t.belongs_to :patient, index:true
      t.boolean :if_sample
      t.integer :interview
      t.integer :biological_sample
      t.date :date_of_sampling
      t.string :sample_number

      t.timestamps null: false
    end
  end
end
