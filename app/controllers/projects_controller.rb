class ProjectsController < ApplicationController
  layout 'project_inner',only: [:show,:edit]
  before_action :authenticate_user!
  load_resource :except=>[:destroy]
  authorize_resource
  helper_method :sort_column, :sort_direction
  def new
    @project.relationships.new
    @project.experimental_medications.new
    @project.center_project_relationships.new
  end

  def show
  end

  def create
    respond_to do |format|
      if @project.save
        format.html { redirect_to project_path(@project) }
      else
        format.html { render :new }
      end
    end
  end
  def edit
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_path(@project) }
      else
        format.html { render :edit }
      end
    end
  end

  def index
    @projects = @projects.order("#{sort_column} #{sort_direction}").page(params[:page])
    @projects.each{|project|
      project.set_all_count
    }
  end

  private
  def project_params
    params.require(:project).permit(
        :center_id, :name,:remark,:initiator_id,
        relationships_attributes: [:id,:user_id,:center_id,:_destroy],
        experimental_medications_attributes: [:id,:name,:remark,:_destroy],
        center_project_relationships_attributes: [:id,:center_id,:planned_patients_count,:_destroy]
    )
  end
  def sort_column(c = "id")
    c
  end

  def sort_direction(d = "asc")
    %w[asc desc].include?(params[:direction]) ? params[:direction] : d
  end
end
