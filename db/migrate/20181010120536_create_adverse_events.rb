class CreateAdverseEvents < ActiveRecord::Migration
  def change
    create_table :adverse_events do |t|
      t.belongs_to :patient,index: true
      t.integer :events
      t.date :occurence_date
      t.integer :turnover
      t.date :recover_date
      t.text :remark
      t.integer :NCI_CTCAE_V_4
      t.boolean :is_SAE
      t.integer :is_related_to_drugs

      t.timestamps null: false
    end
  end
end
