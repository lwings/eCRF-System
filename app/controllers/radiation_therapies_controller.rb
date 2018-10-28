class RadiationTherapiesController < ApplicationController
  layout 'patients'
  before_action :authenticate_user!
  before_action :authenticate_project
  load_and_authorize_resource :patient
  load_and_authorize_resource :radiation_therapy, :through => :patient



  def create
    respond_to do |format|
      if @radiation_therapy.save
        format.html { redirect_to patient_radiation_therapy_path(@patient, @radiation_therapy) }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @radiation_therapy.update(radiation_therapy_params)
        format.html { redirect_to patient_radiation_therapy_path(@patient, @radiation_therapy) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @radiation_therapy.destroy
    redirect_to patient_path(params[:patient_id]),  notice: "删除成功"
  end

  private
  def radiation_therapy_params
    params.require(:radiation_therapy).permit(
      :is_radiation,:radiotherapy_site,:therapy_type,
      :radiotherapy_dose,:radiotherapy_start_date,:radiotherapy_end_date
    )
  end
end
