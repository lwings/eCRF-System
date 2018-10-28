class FollowupMonitorsController < ApplicationController
    layout 'patients'
    before_action :authenticate_user!
    load_and_authorize_resource :patient
    load_and_authorize_resource :followup_monitor, :through => :patient, :singleton => true


    def update
      respond_to do |format|
        if @followup_monitor.update(followup_monitor_params)
          format.html { redirect_to patient_followup_monitor_path(@patient) }
        else
          format.html { render :edit }
        end
      end
    end

    private
    def followup_monitor_params
      params.require(:followup_monitor).permit(
          :start_date,:base_followup_days
      )
    end
end
