class ChangeDescriptionTypeInRole < ActiveRecord::Migration
  def change
    change_column :roles,:description,:text
  end
end
