class Course < ActiveRecord::Base
  extend Enumerize
  include Constant


  belongs_to :patient

  has_many :course_medications,dependent: :destroy
  has_many :blood_biochemistry_thes, dependent: :destroy
  has_many :blood_routine_thes, dependent: :destroy

  accepts_nested_attributes_for :blood_routine_thes,
                                reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :blood_biochemistry_thes,
                                reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :course_medications,
                                reject_if: :all_blank, allow_destroy: true
end
