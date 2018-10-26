class MedicationCompletionsController < ApplicationController
  layout 'patients'
  before_action :authenticate_user!
  load_resource :patient
  load_resource :medication_completion, :through => :patient, :singleton => true

  def new
    @medication_completion.blood_biochemistry_meds.new
    @medication_completion.blood_routine_meds.new
    @medication_completion.tumor_maker_meds.new
  end

  def create
    respond_to do |format|
      if @medication_completion.save
        format.html { redirect_to patient_medication_completion_path(@patient) }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @medication_completion.update(update_medication_completion_params)
        format.html { redirect_to patient_medication_completion_path(@patient) }
      else
        format.html { render :edit }
      end
    end
  end


  private
  def medication_completion_params
    params.require(:medication_completion).permit(
      :visit_date,:height,:weight,:ECOG,:physical_examination,:description,
      :if_followup,:breast_Bultra_date,:breast_Bultra_diagnose,:breast_abnormal,
      :abdo_Bultra_date,:abdo_Bultra_diagnose,:abdo_abnormalt,
        blood_biochemistry_meds_attributes: [:id,:name, :value,:sample_date,:unit,:is_local_hospital,:_destroy],
        blood_routine_meds_attributes: [:id,:name, :value,:sample_date,:unit,:is_local_hospital,:_destroy],
        tumor_maker_meds_attributes: [:id,:name, :value,:sample_date,:unit,:is_local_hospital,:_destroy]
    )
  end

  def update_medication_completion_params
    params.require(:medication_completion).permit(
        :height,:weight,:ECOG,:physical_examination,:description,
        :breast_Bultra_date,:breast_Bultra_diagnose,:breast_abnormal,
        :abdo_Bultra_date,:abdo_Bultra_diagnose,:abdo_abnormalt,
        blood_biochemistry_meds_attributes: [:id,:name, :value,:sample_date,:unit,:is_local_hospital,:_destroy],
        blood_routine_meds_attributes: [:id,:name, :value,:sample_date,:unit,:is_local_hospital,:_destroy],
        tumor_maker_meds_attributes: [:id,:name, :value,:sample_date,:unit,:is_local_hospital,:_destroy]
    )
  end
end
