class ChangeBloodValue < ActiveRecord::Migration
  def change
    change_column :blood_routine_meds,:name, :integer
    change_column :blood_routine_meds,:unit, :integer

    change_column :blood_biochemistry_meds,:name, :integer
    change_column :blood_biochemistry_meds,:unit, :integer

    change_column :blood_routines,:name, :integer
    change_column :blood_routines,:unit, :integer

    change_column :blood_biochemistries ,:name, :integer
    change_column :blood_biochemistries ,:unit, :integer

    change_column :blood_routine_thes,:name, :integer
    change_column :blood_routine_thes,:unit, :integer

    change_column :blood_biochemistry_thes ,:name, :integer
    change_column :blood_biochemistry_thes ,:unit, :integer
  end
end
