class Users::SessionsController < Devise::SessionsController

  before_action :configure_sign_in_params

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy
    session.delete(:project_id)
    session.delete(:project_name)
    super
  end

  protected

  # You can put the params you want to permit in the empty array.
  def configure_sign_in_params
    devise_parameter_sanitizer.for(:sign_in) do |user|
      user.permit(:username, :email, :password, :remember_me)
    end
  end
end
