class ProjectsessionsController < ApplicationController
  before_action :authenticate_user!

  def new
    # debugger
    if current_user.any_accessable_projects?
      @available_projects=current_user.projects.all.distinct
      # @available_projects.order(:created_at).page(10)
      @available_projects.each{|project|
        project.set_authorized_centers(current_user)
      }
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
    session.delete(:project_id)
    session.delete(:project_name)
    redirect_to project_system_configuration_path,notice: "项目已退出"
  end

  def system_configuration

  end

  def exception

  end


end
