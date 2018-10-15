class BiologicalSampleCollection < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :interview, in: INTERVIEW_OPT
  enumerize :biological_sample, in: BIOSAMPLE_OPT

end
