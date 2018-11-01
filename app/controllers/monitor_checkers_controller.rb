class MonitorCheckersController < ApplicationController
  before_action :authenticate_user!
  # authorize_resource
  def index
    file_path=Rails.configuration.monitor_log['path']
    @arr=IO.readlines(file_path)
  end
end
