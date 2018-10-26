class ReserachCompletion < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :reason_for_early_quit, in: QUITREASON_OPT

  belongs_to :patient

  after_create :convertStatusToQuit

  def convertStatusToQuit
    if !self.if_complete_therapy_according_to_plan
      self.patient.update(status:4)
    end
  end

end
