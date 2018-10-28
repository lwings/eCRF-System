class PatientsController < ApplicationController
  layout 'application', only: [:index]
  before_action :authenticate_user!
  load_and_authorize_resource :patient
  before_action :loadAvailableCenters,only:[:new,:edit]

  def index

  end
  def new

  end

  def show

  end

  def create
    respond_to do |format|
      if @patient.save
        format.html { redirect_to patient_path(@patient) }
      else
        format.html { render :new }
      end
    end
  end
  def edit
  end

  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to patient_path(@patient) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @patient.destroy
    redirect_to welcome_guide_path, notice: t('delete_succeed')
  end

  private
  def patient_params
    params.require(:patient).permit(
        :center_id, :user_id, :project_id,

        :pid, :name, :ID_number, :phone_number_1,:phone_number_2,

        :hosptalization_number,:followup_left
    )
  end
  def loadAvailableCenters
    centers_list=[]
    current_user.relationships.where(project_id:current_project.id).each{|re|
      centers_list.append(re.center_id)
    }
    @available_centers=Center.find(centers_list)
  end
end
