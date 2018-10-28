class AddInitiatorIdToProjects < ActiveRecord::Migration
  def change
    add_column :projects,:initiator_id,:integer , index: true
  end
end
