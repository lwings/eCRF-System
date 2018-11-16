class RelationshipsController < ApplicationController
  layout 'project_inner'
  before_action :authenticate_user!
  load_and_authorize_resource  :project
  load_and_authorize_resource :relationship
  # load_resource :relationship,:through => :project
  # load_and_authorize_resource  :project,:through => :project, only: [:create]
  def new
    # debugger
  end
  def create
    @relationship.project_id=@project.id
    respond_to do |format|
      if @relationship.save
        # @project=@relationship.project
        format.html { redirect_to project_relationships_path(@project), notice: "添加成功" }
      else
        format.html { render :new }
      end
    end
  end
  def index
    @relationships=Relationship.where(project_id:@project.id).order(:user_id).page(params[:page])
    @relationships.each{|r|
      r.set_username
      r.set_realname
      r.set_centername
    }
  end
  def destroy

    @project=@relationship.project
    @relationship.destroy
    redirect_to project_relationships_path(@project), notice: "删除成功"
  end

  def relationship_params
    params.require(:relationship).permit(
        :id,:user_id,:center_id
    )
  end
end
