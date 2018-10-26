class Center < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :projects, through: :center_project_relationships
end
