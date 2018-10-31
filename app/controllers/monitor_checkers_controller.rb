class MonitorCheckersController < ApplicationController
  before_action :authenticate_user!
  # authorize_resource
  def index
    file_path="/home/little_wings/monitor_log"
    @arr=IO.readlines(file_path)
  end
end
