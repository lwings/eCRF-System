class BloodRoutine < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :name, in: BLOODRNAME_OPT
  enumerize :unit, in: BLOODRNAME_OPT
  belongs_to :basement_assessment

end
