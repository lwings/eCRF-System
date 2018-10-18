class UsersController < ApplicationController
  before_action :authenticate_user!
  load_resource
  # helper_method :sort_column, :sort_direction

  def index
    @users = @users.order("#{sort_column} #{sort_direction}").page(params[:page])

  end

  def show
  end

  def new
    @available_roles = Role.all
    @available_centers=Center.all
  end

  def create
    respond_to do |format|
      # if @user.valid?(current_user.priv) && @user.save
      if @user.save
        format.html { redirect_to({ action: :index }, notice: t('user_notice.user.created')) }
      else
        format.html {
          @available_roles = available_roles(current_user)
          render :new
        }
      end
    end
  end

  def edit
    @available_roles = Role.all
    @available_centers=Center.all
    # TODO: only ajax request are allowed, define 404 view
    if request.xhr?
      render layout: false
      # respond to Ajax request
    else
      render layout: false
      # respond to normal request
    end
  end

  def update
    respond_to do |format|
      if @user.update_without_password(update_params)
        format.html { redirect_to({ action: :index }, notice: t('user_notice.user.updated')) }
      else
        format.html { redirect_to({ action: :index }, alert: @user.errors.full_messages.to_sentence) }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to({ action: :index }, notice: t('user_notice.user.destroyed')) }
    end
  end

  private
  def create_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :realname, :phone,:role_id, :center_id)
  end

  def update_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :realname, :phone,:role_id, :center_id)
  end

  def available_roles(user)
    Role.available(user.role.priv)
  end

  def sort_column(c = "created_at")
    User.column_names.include?(params[:sort]) ? params[:sort] : c
  end

  def sort_direction(d = "desc")
    %w[asc desc].include?(params[:direction]) ? params[:direction] : d
  end
end
