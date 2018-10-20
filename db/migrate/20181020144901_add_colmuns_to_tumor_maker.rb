class AddColmunsToTumorMaker < ActiveRecord::Migration
  def change
    add_column :tumor_maker_meds,:name,:integer, null:  false
    add_column :tumor_maker_meds,:unit,:integer, null:  false
  end
end
