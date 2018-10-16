class Research < ActiveRecord::Base

  has_many :patients, dependent: :destroy
  has_many :research_groups, dependent: :destroy
  has_many :experimental_medications, dependent: :destroy

end
