class CenterProjectRelationship < ActiveRecord::Base
  belongs_to :center
  belongs_to :project
end
