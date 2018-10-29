class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale

  include ProjectsessionsHelper

  def current_ability
    @current_ability||=Ability.new(current_user,current_project)
  end

  protected

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end


  def after_sign_out_path_for(resource)
    new_user_session_path
  end
  def after_sign_in_path_for(resource)
    project_system_configuration_path
  end

  def ct(key, options={})
    options[:scope] ||= 'controllers'
    I18n.t(key, options)
  end

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to '/infringement', notice: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

end
