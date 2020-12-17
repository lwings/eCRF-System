class ChangeIsExistToBeIntegerInNoTargetLesion < ActiveRecord::Migration
  def change
    change_column :no_target_lesions, :is_exist, :integer
  end
end
