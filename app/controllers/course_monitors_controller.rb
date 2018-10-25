class CourseMonitorsController < ApplicationController
  layout 'patients'
  before_action :authenticate_user!
  load_resource :patient
  load_resource :course_monitor, :through => :patient, :singleton => true



  def edit
  end

  def update
    respond_to do |format|
      if @course_monitor.update(group_information_params)
        format.html { redirect_to patient_course_monitor_path(@patient) }
      else
        format.html { render :edit }
      end
    end
  end

  def show
  end


  private
  def course_monitor_params
    params.require(:course_monitor).permit(
     :if_under_research,:current_phase_seq,:current_course_seq,
     :current_day_seq, :if_rest,:current_rest_seq,:record_phase_seq,
     :record_course_seq,:course_diff
    )
  end
end
