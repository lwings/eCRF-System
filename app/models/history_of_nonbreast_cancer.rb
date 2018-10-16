class HistoryOfNonbreastCancer < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :disease_status, in:DIEASESTAT_OPT

  belongs_to :clinical_pathology

end
