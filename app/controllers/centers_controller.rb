class CentersController < ApplicationController
  layout 'systems'
  before_action :authenticate_user!
  load_and_authorize_resource :center
  helper_method :sort_column, :sort_direction
  def new
  end

  def show
  end

  def create
    respond_to do |format|
      if @center.save
        format.html { redirect_to({ action: :index }, notice: "中心创建成功") }
      else
        format.html { render :new }
      end
    end
  end
  def edit
  end

  def update
    respond_to do |format|
      if @center.update(center_params)
        format.html { redirect_to({ action: :index }, notice: "中心资料更新成功") }
      else
        format.html { render :edit }
      end
    end
  end

  def index
    @centers = @centers.order("#{sort_column} #{sort_direction}").page(params[:page])

  end

  private
  def center_params
    params.require(:center).permit(
        :name,:description
    )
  end
  def sort_column(c = "created_at")
    c
  end

  def sort_direction(d = "desc")
    %w[asc desc].include?(params[:direction]) ? params[:direction] : d
  end
end
