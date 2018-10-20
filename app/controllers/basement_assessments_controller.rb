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
      if @basement_assessment.update(basement_assessmentclinical_pathology_params)
        format.html { redirect_to patient_basement_assessment_path(@patient) }
      else
        format.html { render :edit }
      end
    end
  end


  private
  def basement_assessment_params
    params.require(:basement_assessment).permit(
        :patient_id,:primary_lesion,:regional_lympth_node,
        :matastasis,:histological_type,:histological_grading,
        :vascular_invasion, :ER,:PR,:HER2_IHC,:HER2_FISH,
        :Ki67, :AR,:date_of_operation,
        history_nonbreast_cancers_attributes: [:id,:name, :diagnostic_date,:disease_status],
        family_histories_attributes: [:id,:relation_with_patient,:age_at_diagnose,:treatment,:procession_of_disease]
    )
  end
end
