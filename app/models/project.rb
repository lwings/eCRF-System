class Project < ActiveRecord::Base

  belongs_to :center

  has_many :patients, dependent: :destroy
  has_many :user, through:  :relationships
  has_many :researches, dependent: :destroy

end
