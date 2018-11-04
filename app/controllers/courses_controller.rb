class CoursesController < ApplicationController
  layout 'patients'
  before_action :authenticate_user!
  before_action :authenticate_project
  load_and_authorize_resource :patient
  load_and_authorize_resource :course, :through => :patient
  before_action :get_available_experimental_medication

  def new
    @course.blood_biochemistry_thes.new
    @course.blood_routine_thes.new
    @course.course_medications.new

  end

  def create
    respond_to do |format|
      if @course.save

        format.html { redirect_to patient_course_path(@patient, @course) }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @course.update(course_update_params)
        format.html { redirect_to patient_course_path(@patient, @course) }
      else
        format.html { render :edit }
      end
    end
  end

  def show
  end

  def destroy
    @course.destroy
    redirect_to patient_path(params[:patient_id]),  notice: "删除成功"
  end

  private

  def course_params
    params.require(:course).permit(
        :interview,:height,:weight,:body_surface_area,

        blood_biochemistry_thes_attributes: [:id,:name, :value,:sample_date,:unit,:is_local_hospital,:_destroy],
        blood_routine_thes_attributes: [:id,:name, :value,:sample_date,:unit,:is_local_hospital,:_destroy],
        course_medications_attributes: [:id,:experimental_medication_id,:dose,:date_of_administration,:if_delay_administration,
                                        :reason_for_delay,:description_for_delay,:if_change_dose,:reason_for_change,
                                        :description_for_change,:_destroy]
    )
  end

  def course_update_params
    params.require(:course).permit(
        :height,:weight,:body_surface_area,

        blood_biochemistry_thes_attributes: [:id,:name, :value,:sample_date,:unit,:is_local_hospital,:_destroy],
        blood_routine_thes_attributes: [:id,:name, :value,:sample_date,:unit,:is_local_hospital,:_destroy],
        course_medications_attributes: [:id,:experimental_medication_id,:dose,:date_of_administration,:if_delay_administration,
                                        :reason_for_delay,:description_for_delay,:if_change_dose,:reason_for_change,
                                        :description_for_change,:_destroy]
    )
  end

  def get_available_experimental_medication
    @available_experimental_medication=@patient.project.experimental_medications.all
  end

end
