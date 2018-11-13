class BloodRoutineThe < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :name, in: BLOODRNAME_OPT
  enumerize :unit, in: BLOODRUNIT_OPT
  belongs_to :course


  validates :name,presence: true
  validates :value,presence: true
  validates :sample_date,presence: true

end
