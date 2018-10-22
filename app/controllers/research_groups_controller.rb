class ResearchGroupsController < ApplicationController
  layout 'projects'
  before_action :authenticate_user!
  load_resource :research_group

  def new
    @research_group.course_schedules.new
  end
  def create
    respond_to do |format|
      if @research_group.save
        format.html { redirect_to research_group_path( @research_group) }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @research_group.update(research_group_params)
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

  private
  def research_group_params
    params.require(:research_group).permit(
        :name,:remark,:base_followup_days,:project_id,
        course_schedules_attributes: [:id,:number_of_courses,:cure_span,:rest_span,:_destroy],
    )
  end
end
