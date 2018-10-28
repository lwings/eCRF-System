class RolesController < ApplicationController
  layout 'systems'
  before_action :authenticate_user!
  load_and_authorize_resource :role
  # helper_method :sort_column, :sort_direction
  def new
  end

  def show
  end

  def create
    respond_to do |format|
      if @role.save
        format.html { redirect_to(role_path(@role), notice: "角色创建成功") }
      else
        format.html { render :new }
      end
    end
  end
  def edit
  end

  def update
    respond_to do |format|
      if @role.update(role_params)
        format.html { redirect_to({ action: :show }, notice: "角色资料更新成功") }
      else
        format.html { render :edit }
      end
    end
  end

  def index
    @roles = @roles.order(:created_at).page(params[:page])

  end

  private
  def role_params
    params.require(:role).permit(
        :name,:pri,:description
    )
  end

end
