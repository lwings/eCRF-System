class DeathRecordsController < ApplicationController
  layout 'patients'
  before_action :authenticate_user!
  load_resource :patient
  load_resource :death_record, :through => :patient, :singleton => true



  def create
    respond_to do |format|
      if @death_record.save
        format.html { redirect_to action: :show }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @death_record.update(death_record_params)
        format.html { redirect_to action: :show }
      else
        format.html { render :edit }
      end
    end
  end



  private
  def death_record_params
    params.require(:death_record).permit(
        :date_of_death,:cause_of_death,:relation_with_medication
    )
  end
end
