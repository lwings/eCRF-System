class CreateCenters < ActiveRecord::Migration
  def change
    create_table :centers do |t|
      t.string :name, null: false
      t.text :description

      t.timestamps null: false
    end
  end
end
