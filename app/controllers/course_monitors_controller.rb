class CourseMonitorsController < ApplicationController
  layout 'patients'
  before_action :authenticate_user!
  load_and_authorize_resource :patient
  load_and_authorize_resource :course_monitor, :through => :patient, :singleton => true

  def edit
  end

  def update
    respond_to do |format|
      if @course_monitor.update(course_monitor_params)
        format.html { redirect_to patient_course_monitor_path(@patient) }
      else
        format.html { render :edit }
      end
    end
  end

  private
  def course_monitor_params
    params.require(:course_monitor).permit(
      :record_phase_seq,:record_course_seq,:record_day_seq,
      :last_record_date
    )
  end
end
