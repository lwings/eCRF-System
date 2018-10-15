class RadiationTherapy < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :radiotherapy_site, in:RADIOSITE_OPT
  enumerize :therapy_type, in: THERAPYTYPE_OPT

end
