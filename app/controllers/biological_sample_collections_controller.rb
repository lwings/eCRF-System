class BiologicalSampleCollectionsController < ApplicationController
  layout 'patients'
  before_action :authenticate_user!
  before_action :authenticate_project
  load_and_authorize_resource :patient
  load_and_authorize_resource :biological_sample_collection, :through => :patient



  def create
    respond_to do |format|
      if @biological_sample_collection.save
        format.html { redirect_to patient_biological_sample_collection_path(@patient, @biological_sample_collection) }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @biological_sample_collection.update(biological_sample_collection_params)
        format.html { redirect_to patient_biological_sample_collection_path(@patient, @biological_sample_collection) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @biological_sample_collection.destroy
    redirect_to patient_path(params[:patient_id]),  notice: "删除成功"
  end

  private
  def biological_sample_collection_params
    params.require(:biological_sample_collection).permit(
        :biological_sample,
        :date_of_sampling,:sample_number
    )
  end
end
