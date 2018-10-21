class ConcomitantDrugsController < ApplicationController
  layout 'patients'
  before_action :authenticate_user!
  load_resource :patient
  load_resource :concomitant_drug, :through => :patient

  def create
    respond_to do |format|
      if @concomitant_drug.save
        format.html { redirect_to patient_concomitant_drug_path(@patient, @concomitant_drug) }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @concomitant_drug.update(concomitant_drug_params)
        format.html { redirect_to patient_concomitant_drug_path(@patient, @concomitant_drug) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @concomitant_drug.destroy
    redirect_to patient_path(params[:patient_id]),  notice: "删除成功"
  end

  private
  def concomitant_drug_params
    params.require(:concomitant_drug).permit(
    :drugs,:cause_for_this_drug,
    :daily_dose,:unit_of_dose,:tart_date,:end_date
    )
  end
end
