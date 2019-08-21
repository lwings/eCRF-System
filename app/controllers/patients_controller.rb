class PatientsController < ApplicationController
  layout 'application', only: [:index,:all_patients,:under_research,:under_followup,:quit_followup,:quited,
                               :followup_queue,:research_queue]
  before_action :authenticate_user!
  before_action :authenticate_project
  load_and_authorize_resource :patient
  before_action :load_available_centers
  helper_method :sort_column, :sort_direction
  def followup_queue
    @patients=Patient.joins(:followup_monitor).accessible_by(current_ability,:read).where(status:2).where(
        'overdue_followup>0').order("#{sort_column} #{sort_direction}").page(params[:page])
    @patients.each{|patient|
      patient.set_center_name
      patient.set_overdue_courses
      patient.set_overdue_followups
    }
  end

  def research_queue
    @patients=Patient.joins(:course_monitor).accessible_by(current_ability,:read).where(status:1).where(
    'overdue_course>0').order("#{sort_column} #{sort_direction}").page(params[:page])
    @patients.each{|patient|
      patient.set_center_name
      patient.set_overdue_courses
      patient.set_overdue_followups
    }
  end

  def all_patients
    @patients=Patient.accessible_by current_ability,:read
    @patients = @patients.order("#{sort_column} #{sort_direction}").page(params[:page])
    @patients.each{|patient|
      patient.set_center_name
      patient.set_overdue_courses
      patient.set_overdue_followups
    }
  end

  def under_research
    @patients=Patient.accessible_by(current_ability,:read).where('
    status=1').order("#{sort_column} #{sort_direction}").page(params[:page])
    @patients.each{|patient|
      patient.set_center_name
      patient.set_overdue_courses
      patient.set_overdue_followups
    }
  end

  def under_followup
    @patients=Patient.accessible_by(current_ability,:read).where('
    status=2').order("#{sort_column} #{sort_direction}").page(params[:page])
    @patients.each{|patient|
      patient.set_center_name
      patient.set_overdue_courses
      patient.set_overdue_followups
    }
  end

  def quit_followup
    @patients=Patient.accessible_by(current_ability,:read).where('
    status=3').order("#{sort_column} #{sort_direction}").page(params[:page])
    @patients.each{|patient|
      patient.set_center_name
      patient.set_overdue_courses
      patient.set_overdue_followups
    }
  end

  def quited
    @patients=Patient.accessible_by(current_ability,:read).where('
    status=4').order("#{sort_column} #{sort_direction}").page(params[:page])
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

    get_total_authorized_center_patients

    get_center_planned_patients

    get_project_total_planned_patients

    get_center_patients

    @followup_queue_size=get_followup_queue_size

    @research_queue_size=get_research_queue_size

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
    respond_to do |format|
      if @patient.courses.size != 0 || @patient.followups.size!=0
        format.html { redirect_to patient_path(@patient), alert: "必须先删除所有疗程以及随访记录" }
      else
        @patient.destroy
        format.html { redirect_to patients_path, notice: "删除成功"}
      end
    end

  end

  private
  def patient_params
    params.require(:patient).permit(
        :center_id, :user_id, :project_id,

        :pid, :name, :ID_number, :phone_number_1,:phone_number_2,:date_of_birth,

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

  def get_center_planned_patients
    @center_planned_patients={}
    current_user.relationships.where(project_id:current_project.id).each{|r|

      inquire=CenterProjectRelationship.find_by(project_id: current_project.id,
                                                center_id:r.center_id)
      if inquire.nil?
        @center_planned_patients[r.center.name]=0
      else
        @center_planned_patients[r.center.name]=inquire.planned_patients_count
      end
    }
  end

  def get_project_total_planned_patients
    @project_total_planned_patients=0
    current_project.center_project_relationships.all.each{|cpr|
      @project_total_planned_patients+=cpr.planned_patients_count
    }
    @project_total_patients=Patient.where(project_id:current_project.id).size()
  end

  def get_total_authorized_center_patients
    @project_totalauthorized_center_patients=Patient.accessible_by(current_ability,:read).size()
  end

  def get_center_patients
    @center_patients={}
    current_user.relationships.where(project_id:current_project.id).each{|r|
      @center_patients[r.center.name]=Patient.where(project_id:current_project.id,center_id:r.center_id).size
    }
  end

  def get_followup_queue_size
    @patients=Patient.joins(:followup_monitor).accessible_by(current_ability,:read).where(status:2).where(
        'overdue_followup>0').order(:created_at).page(params[:page]).size
  end

  def get_research_queue_size
    @patients=Patient.joins(:course_monitor).accessible_by(current_ability,:read).where(status:1).where(
        'overdue_course>0').order(:created_at).page(params[:page]).size
  end

  def sort_column(c = "created_at")
    c
  end

  def sort_direction(d = "asc")
    %w[asc desc].include?(params[:direction]) ? params[:direction] : d
  end
end
