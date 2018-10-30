class UsersController < ApplicationController
  layout 'systems'
  before_action :authenticate_user!
  load_and_authorize_resource :user
  before_action :get_available_roles,only: [:new,:edit,:show]
  # helper_method :sort_column, :sort_direction

  def index
    @users = User.accessible_by(current_ability,:read)
    @users = @users.order(:created_at).page(params[:page])
    @users.each{|user|
      user.set_all_count
    }
  end

  def show

  end

  def new
  end

  def create
    respond_to do |format|
      if @user.save
        format.html { redirect_to({ action: :index }, notice: "用户创建成功") }
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
        format.html { redirect_to({ action: :index }, notice: "用户资料更新成功") }
      else
        format.html { redirect_to({ action: :index }, alert: @user.errors.full_messages.to_sentence) }
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
        :realname, :phone,:role_id)
  end

  def get_available_roles
    if current_user.role.pri==0
      @available_roles=Role.all
    else
      @available_roles=Role.where('pri>?',current_user.role.pri)
    end

  end

end
