class ResearchGroupsController < ApplicationController
  layout 'projects'
  before_action :authenticate_user!
  load_and_authorize_resource :research_group
  helper_method :sort_column, :sort_direction
  before_action :get_available_projects
  def new
    @research_group.course_schedules.new
  end
  def create
    respond_to do |format|
      if research_group_params[:course_schedules_attributes].nil?
        format.html { redirect_to({ action: :new }, alert: "疗程计划不能为空") }
      elsif @research_group.save
        format.html { redirect_to research_group_path( @research_group) }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if  research_group_params[:course_schedules_attributes].nil?
        format.html { redirect_to({ action: :edit }, alert: "疗程计划不能为空") }
      elsif @research_group.update(research_group_params)
        format.html { redirect_to research_group_path( @research_group) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @research_group.destroy
    redirect_to research_group_path(params[:project_id]),  notice: "删除成功"
  end

  def index
    @research_groups = @research_groups.order(:created_at).page(params[:page])
    @research_groups.each{|research_group|
      research_group.set_all_count
    }
  end

  private
  def research_group_params
    params.require(:research_group).permit(
        :name,:remark,:base_followup_days,:project_id,:base_interval,
        course_schedules_attributes: [:id,:seq,:number_of_courses,:cure_span,:rest_span,:_destroy],
    )
  end
  def sort_column(c = "created_at")
    Project.column_names.include?(params[:sort]) ? params[:sort] : c
  end

  def sort_direction(d = "desc")
    %w[asc desc].include?(params[:direction]) ? params[:direction] : d
  end

  def get_available_projects
    if current_user.role.pri==0 || current_user.role.pri==1
      @available_projects=Project.all
    else
      @available_projects=current_user.self_projects.all
    end
  end
end
