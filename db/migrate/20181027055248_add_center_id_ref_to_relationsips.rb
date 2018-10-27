class AddCenterIdRefToRelationsips < ActiveRecord::Migration
  def change
    add_reference :relationships, :center, index: true
  end
end
