class HistoryOfNonbreastCancer < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :disease_status, in:DIEASESTAT_OPT

  belongs_to :clinical_pathology


  validates :name,presence: true
  validates :diagnostic_date,presence: true
  validates :disease_status,presence: true

end
