class RadiationTherapy < ActiveRecord::Base
  extend Enumerize
  include Constant
  include FlagShihTzu

  enumerize :therapy_type, in: THERAPYTYPE_OPT

  has_flags 1=>:chest_wall,2=>:axilla,3=>:collarbone,4=>:internal_breast,
            5=>:whole_breast,6=>:tumor_bed_boost,7=>:others,8=>:unkown,column:"radiotherapy_site"

  belongs_to :patient

end
