class ProjectsController < ApplicationController
  before_action :authenticate_user!
  load_resource :except=>[:destroy]
  # helper_method :sort_column, :sort_direction
  def new
    @project.relationships.new
    @project.experimental_medications.new
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
    @projects = @projects.order(:created_at).page(params[:page])
    @projects.each{|project|
      project.set_all_count
    }
  end

  private
  def project_params
    params.require(:project).permit(
        :center_id, :name,:remark,
        relationships_attributes: [:id,:user_id,:_destroy],
        experimental_medications_attributes: [:id,:name,:remark,:_destroy]
    )
  end
  # def sort_column(c = "created_at")
  #   Project.column_names.include?(params[:sort]) ? params[:sort] : c
  # end
  #
  # def sort_direction(d = "desc")
  #   %w[asc desc].include?(params[:direction]) ? params[:direction] : d
  # end
end
