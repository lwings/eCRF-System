class CenterProjectRelationship < ActiveRecord::Base
  belongs_to :center
  belongs_to :project

  # validates :project_id,presence: true
  # validates :center_id,presence: true
  validates :planned_patients_count,presence: true,inclusion: { in: 1..99999,
                                                                message: "病例数须为正整数" }
end
