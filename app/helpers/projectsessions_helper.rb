module ProjectsessionsHelper

  def current_project_id
    session[:project_id]
  end

  def current_project_name
    session[:project_name]
  end

  def set_current_project_id
    session[:project_id]=params[:project][:project]
  end

  def set_current_project_name
    session[:project_name]=Project.find(params[:project][:project]).name
  end

end
