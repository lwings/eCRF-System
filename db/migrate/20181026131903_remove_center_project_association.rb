class RemoveCenterProjectAssociation < ActiveRecord::Migration
  def change
    remove_index :projects,:center_id
    remove_column :projects,:center_id
  end
end
