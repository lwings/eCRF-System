class Relationship < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  belongs_to :center

  validates :project_id,presence: true
  validates :center_id,presence: true
  validates :user_id,presence: true
end
