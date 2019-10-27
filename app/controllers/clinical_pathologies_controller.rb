class ClinicalPathologiesController < ApplicationController
  layout 'patients'
  before_action :authenticate_user!
  before_action :authenticate_project
  load_and_authorize_resource :patient
  load_and_authorize_resource :clinical_pathology, :through => :patient, :singleton => true

  def new
    @clinical_pathology.history_of_nonbreast_cancers.new
    @clinical_pathology.family_histories.new

    @clinical_pathology.first_diagnosis_clinical_phases.new
    @clinical_pathology.biopsy_clinical_infos.new
    @clinical_pathology.operation_clinical_infos.new
  end

  def create
    respond_to do |format|
      if @clinical_pathology.save
        format.html { redirect_to patient_clinical_pathology_path(@patient) }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @clinical_pathology.update(clinical_pathology_params)
        format.html { redirect_to patient_clinical_pathology_path(@patient) }
      else
        format.html { render :edit }
      end
    end
  end


  private
  def clinical_pathology_params
    params.require(:clinical_pathology).permit(
        :patient_id,:primary_lesion,:regional_lympth_node,:op_breast_mode,:op_armpit_mode,:comment,
        :matastasis,:histological_type,:histological_grading,
        :vascular_invasion, :ER,:PR,:HER2_IHC,:HER2_FISH,
        :Ki67, :AR,:date_of_operation,
        history_of_nonbreast_cancers_attributes: [:name, :diagnostic_date,:disease_status,:id,:_destroy],
        family_histories_attributes: [:id,:relation_with_patient,:age_at_diagnose,
                                      :treatment,:procession_of_disease,:_destroy],

        first_diagnosis_clinical_phases_attributes: [:id, :primary_lesion, :regional_lympth_node, :matastasis, :_destroy],
        biopsy_clinical_infos_attributes: [:id, :biopsy_position, :biopsy_position_remark, :biopsy_date, :biopsy_mode,
                                      :histological_type, :histological_grading, :ER, :ER_strength, :PR, :PR_strength,
                                      :HER2_IHC, :HER2_FISH, :Ki67, :AR, :AR_strength, :comment, :_destroy],
        operation_clinical_infos_attributes: [:id, :op_position, :op_date, :op_breast_mode, :op_armpit_mode, :tumor_size,
                                      :lympth_matastasis_cnt, :histological_type, :histological_grading, :ER, :ER_strength,
                                      :PR, :PR_strength, :HER2_IHC, :HER2_FISH, :Ki67, :AR, :AR_strength, :comment, :_destroy]
    )
  end
end
