class PatientsController < ApplicationController
  layout 'application', only: [:index,:all_patients,:under_research,:under_followup,:quit_followup,:quited]
  before_action :authenticate_user!
  before_action :authenticate_project
  load_and_authorize_resource :patient
  before_action :load_available_centers,only:[:new,:edit]

  def followup_queue

  end

  def research_queue

  end

  def all_patients
    @patients=Patient.accessible_by current_ability,:read
    @patients = @patients.order(:created_at).page(params[:page])
    @patients.each{|patient|
      patient.set_center_name
      patient.set_overdue_courses
      patient.set_overdue_followups
    }
  end

  def under_research
    @patients=Patient.accessible_by(current_ability,:read).where('
    status=1').order(:created_at).page(params[:page])
    @patients.each{|patient|
      patient.set_center_name
      patient.set_overdue_courses
      patient.set_overdue_followups
    }
  end

  def under_followup
    @patients=Patient.accessible_by(current_ability,:read).where('
    status=2').order(:created_at).page(params[:page])
    @patients.each{|patient|
      patient.set_center_name
      patient.set_overdue_courses
      patient.set_overdue_followups
    }
  end

  def quit_followup
    @patients=Patient.accessible_by(current_ability,:read).where('
    status=3').order(:created_at).page(params[:page])
    @patients.each{|patient|
      patient.set_center_name
      patient.set_overdue_courses
      patient.set_overdue_followups
    }
  end

  def quited
    @patients=Patient.accessible_by(current_ability,:read).where('
    status=4').order(:created_at).page(params[:page])
    @patients.each{|patient|
      patient.set_center_name
      patient.set_overdue_courses
      patient.set_overdue_followups
    }
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

  def index
    @project_total_planned_patients=0
    current_project.center_project_relationships.all.each{|cpr|
      @project_total_planned_patients+=cpr.planned_patients_count
    }
    @project_total_patients=Patient.where(project_id:current_project.id).size()
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

  def load_available_centers
    centers_list=[]
    current_user.relationships.where(project_id:current_project.id).each{|re|
      centers_list.append(re.center_id)
    }
    @available_centers=Center.find(centers_list)
  end

  # def load_patients
  #   @patients=Patient.accessible_by current_ability,:read
  #   @patients = @patients.order(:created_at).page(params[:page])
  #
  #   @patients.each{|patient|
  #     patient.set_center_name
  #     patient.set_overdue_courses
  #     patient.set_overdue_followups
  #   }
  # end

end
