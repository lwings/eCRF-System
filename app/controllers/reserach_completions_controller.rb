class ReserachCompletionsController < ApplicationController
  layout 'patients'
  before_action :authenticate_user!
  before_action :authenticate_project
  load_and_authorize_resource :patient
  load_and_authorize_resource :reserach_completion, :through => :patient, :singleton => true

  def new
  end

  def create
    respond_to do |format|
      if @reserach_completion.save
        format.html { redirect_to patient_reserach_completion_path(@patient) }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @reserach_completion.update(update_reserach_completion_params)
        format.html { redirect_to patient_reserach_completion_path(@patient) }
      else
        format.html { render :edit }
      end
    end
  end

  def show
  end


  private
  def reserach_completion_params
    params.require(:reserach_completion).permit(
     :date_of_last_confirmation,:if_complete_therapy_according_to_plan,
     :reason_for_early_quit,:description
    )
  end
  def update_reserach_completion_params
    params.require(:reserach_completion).permit(
        :date_of_last_confirmation,
        :reason_for_early_quit,:description
    )
  end
end
