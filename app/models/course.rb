class Course < ActiveRecord::Base
  extend Enumerize
  include Constant


  belongs_to :patient

  has_many :course_medications,dependent: :destroy
  has_many :blood_biochemistry_thes, dependent: :destroy
  has_many :blood_routine_thes, dependent: :destroy

end
