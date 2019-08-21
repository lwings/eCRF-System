class AddCommentToClinicalPathologies < ActiveRecord::Migration
  def change
    add_column :clinical_pathologies, :comment, :string
  end
end
