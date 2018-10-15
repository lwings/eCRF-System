class BasementAssessment < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :pregnancy_test_result, in:TRIPLET_OPT_II
  enumerize :electrocarddiogram_diagnosis, in:DIAGNOSE_OPT


end
