class CenterRefToPatient < ActiveRecord::Migration
  def change
    add_reference :patients, :center, index: true
    add_foreign_key :patients, :centers
  end
end
