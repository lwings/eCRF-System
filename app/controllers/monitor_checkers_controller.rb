class MonitorCheckersController < ApplicationController
  before_action :authenticate_user!
  def index
    if can? :read, MonitorCheckersController
      file_path=Rails.configuration.monitor_log['path']
      @arr=IO.readlines(file_path)
    else
      redirect_to '/infringement'
    end
  end
end
