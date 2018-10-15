class HistoryOfNonbreastCancer < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :disease_status, in:DIEASESTAT_OPT

end
