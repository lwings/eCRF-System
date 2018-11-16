class RelationshipsController < ApplicationController
  layout 'project_inner'
  before_action :authenticate_user!
  load_and_authorize_resource  :project
  load_and_authorize_resource :relationship
  before_action :get_relationships,only:[:new,:index]
  helper_method :sort_column, :sort_direction
  # load_resource :relationship,:through => :project
  # load_and_authorize_resource  :project,:through => :project, only: [:create]
  def new

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

  def get_relationships
    @relationships=Relationship.where(project_id:@project.id).order("#{sort_column} #{sort_direction}").page(params[:page])
    @relationships.each{|r|
      r.set_username
      r.set_realname
      r.set_centername
    }
  end

  private
  def sort_column(c = "user_id")
    dbname=Relationship.transfer_col_name(params[:sort])
    dbname.nil? ? c:dbname
  end

  def sort_direction(d = "asc")
    %w[asc desc].include?(params[:direction]) ? params[:direction] : d
  end
end
