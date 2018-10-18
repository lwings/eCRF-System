class ProjectsessionsController < ApplicationController
  before_action :authenticate_user!

  def new

    if current_user.any_accessable_projects?

    else
      redirect_to action: :exception
    end

  end
  def create

  end
  def destroy

  end
  def exception

  end


end
