class RemoveCenterUserAssociation < ActiveRecord::Migration
  def change
    remove_index :users,:center_id
    remove_column :users,:center_id
  end
end
