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

  def current_project
    Project.find(current_project_id)
  end

  def authenticate_project
    if session[:project_id].nil? || session[:project_name].nil?
      redirect_to project_login_path,alert: "必须先登录中心"
    end
  end


end
