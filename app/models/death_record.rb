class DeathRecord < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :relation_with_medication, in: RELAITHDRUGS_OPT
  enumerize :cause_of_death, in: DEATH_OPT

end
