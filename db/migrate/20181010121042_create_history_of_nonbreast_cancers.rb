class CreateHistoryOfNonbreastCancers < ActiveRecord::Migration
  def change
    create_table :history_of_nonbreast_cancers do |t|
      t.belongs_to :clinical_pathology, index: true
      t.string :name, null:false
      t.date :diagnostic_date
      t.integer :disease_status
      

      t.timestamps null: false
    end
  end
end
