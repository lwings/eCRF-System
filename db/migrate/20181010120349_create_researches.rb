class CreateResearches < ActiveRecord::Migration
  def change
    create_table :researches do |t|
      t.string :name, null:false
      t.text :description

      t.timestamps null: false
    end
  end
end
