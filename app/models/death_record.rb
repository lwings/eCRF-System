class DeathRecord < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :relation_with_medication, in: RELAITHDRUGS_OPT
  enumerize :cause_of_death, in: DEATH_OPT

  belongs_to :patient

  validates :date_of_death,presence: true
  validates :cause_of_death,presence: true


  after_create :convertStatusToQuit

  def convertStatusToQuit
    self.patient.update(status:4)
  end

end
