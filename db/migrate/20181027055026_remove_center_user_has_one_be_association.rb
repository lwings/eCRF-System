class RemoveCenterUserHasOneBeAssociation < ActiveRecord::Migration
  def change
    drop_table :centers_users
  end
end
