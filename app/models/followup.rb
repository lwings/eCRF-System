class Followup < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :cause_of_death, in:DEATH_OPT

  belongs_to :patient

end
