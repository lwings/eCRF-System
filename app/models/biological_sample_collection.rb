class BiologicalSampleCollection < ActiveRecord::Base
  extend Enumerize
  include Constant

  # enumerize :interview, in: INTERVIEW_OPT
  enumerize :biological_sample, in: BIOSAMPLE_OPT

  belongs_to :patient

  validates :biological_sample,presence: true
  validates :date_of_sampling,presence: true
  validates :sample_number,presence: true

end
