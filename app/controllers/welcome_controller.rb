class WelcomeController < ApplicationController
  before_action :authenticate_user!
  def new
  end

  def guide
  end
end
