class TargetLesion < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :inspection_method, in: INSPECTIONMETHOD_OPT
  belongs_to :tumor_evaluation

  validates :position, presence: true
end
