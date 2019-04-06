class ConcomitantDrug < ActiveRecord::Base

  belongs_to :patient

  validates :drugs,presence: true
  #validates :daily_dose,presence: true
end
