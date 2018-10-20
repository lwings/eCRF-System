class BasementAssessmentsController < ApplicationController
  layout 'patients'
  before_action :authenticate_user!
  load_resource :patient
  load_resource :basement_assessment, :through => :patient, :singleton => true

  def new
    @basement_assessment.blood_biochemistries.new
    @basement_assessment.blood_routines.new
  end

  def create
    respond_to do |format|
      if @basement_assessment.save
        format.html { redirect_to patient_basement_assessment_path(@patient) }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @basement_assessment.update(basement_assessment_params)
        format.html { redirect_to patient_basement_assessment_path(@patient) }
      else
        format.html { render :edit }
      end
    end
  end


  private
  def basement_assessment_params
    params.require(:basement_assessment).permit(
      :height,:weight,:BMI,:systolic_blood_pressure,:diastolic_blood_pressure,
      :physical_state_assessment,:pregnancy_test_date,:pregnancy_test_result,:electrocardiogram_date,
      :electrocarddiogram_diagnosis,:electrocarddiogram_description,:breast_B_ultrasound_date,
      :breast_B_ultrasound_date_diagnosis,:breast_B_ultrasound_date_description,:Mammography_date,
      :Mammography_diagnosis,:Mammography_description,:abdominal_B_ultrasound_date,
      :abdominal_B_ultrasound_date_diagnosis,:abdominal_B_ultrasound_date_description,:breast_CT_date,
      :breast_CT_diagnosis,:breast_CT_description,:echocardiography_date,:LVEF,
      :echocardiography_diagnosis,:echocardiography_description,
      blood_biochemistries_attributes: [:id,:name, :value,:sample_date,:unit,:_destory],
      blood_routines: [:id,:name, :value,:sample_date,:unit,:_destory]
    )
  end
end
