class Research < ActiveRecord::Base

  belongs_to :project

  has_many :patients, dependent: :destroy
  has_many :research_groups, dependent: :destroy
  has_many :experimental_medications, dependent: :destroy

end
