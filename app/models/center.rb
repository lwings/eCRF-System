class Center < ActiveRecord::Base
  has_many :projects, through: :center_project_relationships
  has_many :users, through: :relationships
  has_many :patients
end
