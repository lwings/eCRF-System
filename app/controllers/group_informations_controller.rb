class GroupInformationsController < ApplicationController
  layout 'patients'
  before_action :authenticate_user!
  before_action :authenticate_project
  load_and_authorize_resource :patient
  load_and_authorize_resource :group_information, :through => :patient, :singleton => true

  def new
    @available_research_groups=@patient.project.research_groups.all
  end

  def create
    respond_to do |format|
      if @group_information.save
        format.html { redirect_to patient_group_information_path(@patient) }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @available_research_groups=@patient.project.research_groups.all
  end

  def update
    respond_to do |format|
      if @group_information.update(group_information_params)
        format.html { redirect_to patient_group_information_path(@patient) }
      else
        format.html { render :edit }
      end
    end
  end
  def show
    @available_research_groups=@patient.project.research_groups.all
  end


  private
  def group_information_params
    params.require(:group_information).permit(
        :patient_id,:research_group_id,:is_meet_inclusion_criteria,
        :inform_consent_date,:random_groping_date
    )
  end
end
