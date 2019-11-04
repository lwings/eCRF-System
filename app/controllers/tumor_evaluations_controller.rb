class TumorEvaluationsController < ApplicationController
  layout 'patients'
  before_action :authenticate_user!
  before_action :authenticate_project
  load_and_authorize_resource :patient
  load_and_authorize_resource :tumor_evaluation, :through => :patient, :singleton => true

  def new
    @tumor_evaluation.target_lesions.new
    @tumor_evaluation.no_target_lesions.new
    @tumor_evaluation.new_lesions.new
  end

  def create
    respond_to do |format|
      calculation()
      if @tumor_evaluation.save
        format.html {redirect_to patient_tumor_evaluation_path(@patient, @tumor_evaluation)}
      else
        format.html {render :new}
      end
    end
  end

  def edit

  end

  def update
    respond_to do |format|
      calculation()
      if @tumor_evaluation.update(tumor_evaluation_update_params)
        format.html {redirect_to patient_tumor_evaluation_path(@patient, @tumor_evaluation)}
      else
        format.html {render :edit}
      end
    end
  end

  def show
    calculation()
  end
  def destroy
    @tumor_evaluation.destroy
    redirect_to patient_path(params[:patient_id]), notice: "删除成功"
  end

  private

  def tumor_evaluation_params
    params.require(:tumor_evaluation).permit(
        :date, :interview, :patient_id, :sum_diameter,
        :base_line_diameter, :cmp_base_line_diameter,
        :min_diameter, :cmp_min_diameter,
        :target_lesion_evaluation, :no_target_lesion_evaluation,
        :lesion_evaluation, :comment,
        target_lesions_attributes: [:id, :position, :inspection_method, :max_diameter, :_destroy],
        no_target_lesions_attributes: [:id, :position, :inspection_method, :is_exist, :_destroy],
        new_lesions_attributes: [:id, :position, :inspection_method, :date, :_destroy]
    )
  end
  def tumor_evaluation_update_params
    params.require(:tumor_evaluation).permit(
        :date, :interview, :patient_id, :sum_diameter,
        :base_line_diameter, :cmp_base_line_diameter,
        :min_diameter, :cmp_min_diameter,
        :target_lesion_evaluation, :no_target_lesion_evaluation,
        :lesion_evaluation, :comment,
        target_lesions_attributes: [:id, :position, :inspection_method, :max_diameter, :_destroy],
        no_target_lesions_attributes: [:id, :position, :inspection_method, :is_exist, :_destroy],
        new_lesions_attributes: [:id, :position, :inspection_method, :date, :_destroy]
    )
  end

  def calculation
    # for evaluations in @patient.tumor_evaluations
    #
    # end
    p "hehehe"
    sum_size = 0
    for lesions in @tumor_evaluation.target_lesions
      sum_size += lesions.max_diameter
    end
    @tumor_evaluation.sum_diameter = sum_size
    base_sum_size = 0
    if @patient.tumor_evaluations.size == 0
      @tumor_evaluation.base_line_diameter = sum_size
    else
      for i in @patient.tumor_evaluations
        p i.sum_diameter
      end
      if @tumor_evaluation.id == @patient.tumor_evaluations[0].id
        @tumor_evaluation.base_line_diameter = sum_size
        p "case 1"
      else
        @tumor_evaluation.base_line_diameter = @patient.tumor_evaluations[0].sum_diameter
        p "case 2"
      end
    end
    if @tumor_evaluation.base_line_diameter != 0
      @tumor_evaluation.cmp_base_line_diameter = (@tumor_evaluation.sum_diameter -
            @tumor_evaluation.base_line_diameter) / @tumor_evaluation.base_line_diameter
      if -1e-6 < @tumor_evaluation.cmp_base_line_diameter and @tumor_evaluation.cmp_base_line_diameter < 1e-6
        @tumor_evaluation.cmp_base_line_diameter = 0
      end
      @tumor_evaluation.cmp_base_line_diameter *= 100
    end
    min_sum_size = 999999.0
    for evaluation in @patient.tumor_evaluations
      p evaluation.sum_diameter
      if evaluation.sum_diameter < min_sum_size
        min_sum_size = evaluation.sum_diameter
      end
    end
    if min_sum_size > sum_size
      min_sum_size = sum_size
    end
    @tumor_evaluation.min_diameter = min_sum_size
    if min_sum_size != 0
      @tumor_evaluation.cmp_min_diameter = (sum_size - min_sum_size) / min_sum_size
      if -1e-6 < @tumor_evaluation.cmp_min_diameter and @tumor_evaluation.cmp_min_diameter < 1e-6
        @tumor_evaluation.cmp_min_diameter = 0
      end
      @tumor_evaluation.cmp_min_diameter *= 100
    end
  end
end
