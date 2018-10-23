class UsersController < ApplicationController
  layout 'systems'
  before_action :authenticate_user!
  load_resource :user

  # helper_method :sort_column, :sort_direction

  def index
    @users = @users.order(:created_at).page(params[:page])
    @users.each{|user|
      user.set_all_count
    }
  end


  def new
    @user.relationships.new
  end

  def create
    respond_to do |format|
      if @user.save
        format.html { redirect_to({ action: :show }, notice: "用户创建成功") }
      else
        format.html {
          render :new
        }
      end
    end
  end



  def update
    respond_to do |format|
      if @user.update_without_password(user_params)
        format.html { redirect_to({ action: :show }, notice: "用户资料更新成功") }
      else
        format.html { redirect_to({ action: :show }, alert: @user.errors.full_messages.to_sentence) }
      end
    end
  end

  def destroy
    if @user.is_superintendent?
      redirect_to({ action: :index },alert:"超级管理员无法删除" )
    else
      @user.destroy
      redirect_to({ action: :index },notice: "删除成功")
    end
  end

  private
  def user_params
    params.require(:user).permit(
        :username, :email, :password, :password_confirmation,
        :realname, :phone,:role_id, :center_id,
        relationships_attributes: [:id,:project_id,:_destroy],center_ids: [])
  end

  # def sort_column(c = "created_at")
  #   User.column_names.include?(params[:sort]) ? params[:sort] : c
  # end
  #
  # def sort_direction(d = "desc")
  #   %w[asc desc].include?(params[:direction]) ? params[:direction] : d
  # end/
end
