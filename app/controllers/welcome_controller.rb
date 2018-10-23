class WelcomeController < ApplicationController
  before_action :authenticate_user!
  def new
  end

  def guide
    @allCenter=""
    current_user.centers.all.each{|center|
      @allCenter+=(center.name+"\\")
    }
  end
end
