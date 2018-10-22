class ProjectsController < ApplicationController
  before_action :authenticate_user!
  load_resource :project

  def new
    @project.relationships.new
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


  private
  def project_params
    params.require(:project).permit(
        :center_id, :name,:remark,
        relationships_attributes: [:id,:user_id,:_destroy]
    )
  end
end
