class AdverseEventsController < ApplicationController
  layout 'patients'
  before_action :authenticate_user!
  before_action :authenticate_project
  load_and_authorize_resource :patient
  load_and_authorize_resource :adverse_event, :through => :patient



  def create
    respond_to do |format|
      if @adverse_event.save
        format.html { redirect_to patient_adverse_event_path(@patient, @adverse_event) }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @adverse_event.update(adverse_event_params)
        format.html { redirect_to patient_adverse_event_path(@patient, @adverse_event) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @adverse_event.destroy
    redirect_to patient_path(params[:patient_id]),  notice: "删除成功"
  end

  private
  def adverse_event_params
    params.require(:adverse_event).permit(
        :events, :events,:occurence_date,:turnover,:recover_date,
        :remark,:NCI_CTCAE_V_4,:is_SAE,:is_related_to_drugs
    )
  end
end
