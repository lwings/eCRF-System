class AdverseEvent < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :events, in:EVENTS_OPT
  enumerize :turnover, in:TURNOVER_OPT
  enumerize :is_related_to_drugs, in:RELAITHDRUGS_OPT

  belongs_to :patient

end
