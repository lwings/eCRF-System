class ReserachCompletion < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :reason_for_early_quit, in: QUITREASON_OPT

end
