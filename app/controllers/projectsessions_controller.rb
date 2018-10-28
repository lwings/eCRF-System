class ProjectsessionsController < ApplicationController
  before_action :authenticate_user!

  def new

    if current_user.any_accessable_projects?
      @available_projects=current_user.projects.all.distinct
    else
      redirect_to action: :exception
    end

  end

  def create
    set_current_project_id
    set_current_project_name
    redirect_to welcome_guide_path
  end

  def destroy

  end

  def exception

  end


end
