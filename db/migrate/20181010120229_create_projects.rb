class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.belongs_to :center, index:true
      t.string :name, null: false
      t.text :remark

      t.timestamps null: false
    end
  end
end
