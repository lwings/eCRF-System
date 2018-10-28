class FollowupsController < ApplicationController
  layout 'patients'
  before_action :authenticate_user!
  load_and_authorize_resource :patient
  load_and_authorize_resource :followup, :through => :patient



  def create
    respond_to do |format|
      if @followup.save
        format.html { redirect_to patient_followup_path(@patient, @followup) }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @followup.update(update_follow_up_params)
        format.html { redirect_to patient_followup_path(@patient, @followup) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @followup.destroy
    redirect_to patient_path(params[:patient_id]),  notice: "删除成功"
  end

  private
  def followup_params
    params.require(:followup).permit(
     :date_of_visit,:local_recurrence,:date_of_local_recurrence,:matastasis,
     :date_of_matastasis,:contralateral_breast_cancer,:date_of_contralateral_breast_cancer,
     :second_primary_cancer,:date_of_second_primary_cancer,:death,:date_of_death,:cause_of_death
    )
  end
  def update_followup_params
    params.require(:followup).permit(
        :local_recurrence,:date_of_local_recurrence,:matastasis,
        :date_of_matastasis,:contralateral_breast_cancer,:date_of_contralateral_breast_cancer,
        :second_primary_cancer,:date_of_second_primary_cancer,:death,:date_of_death,:cause_of_death
    )
  end
end
