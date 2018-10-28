class WelcomeController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_project
  def new
  end

  def guide
    # @all_center=""
    # current_user.centers.all.each{|center|
    #   @all_center+=(center.name+"\\")
    # }

    @available_centers=""
    current_user.relationships.where(project_id:current_project.id).each{|re|
      @available_centers+=(re.center.name+"\\")
    }
  end
end
