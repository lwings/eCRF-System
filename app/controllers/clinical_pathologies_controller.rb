class ClinicalPathologiesController < ApplicationController
  layout 'patients'
  before_action :authenticate_user!
  load_resource :patient
  load_resource :clinical_pathology, :through => :patient, :singleton => true

  def new

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
        :patient_id,:primary_lesion,:regional_lympth_node,
        :matastasis,:histological_type,:histological_grading,
        :vascular_invasion, :ER,:PR,:HER2_IHC,:HER2_FISH,
        :Ki67, :AR,:date_of_operation
    )
  end
end
