class Project < ActiveRecord::Base

  belongs_to :center

  has_many :patients, dependent: :destroy
  has_many :user
  has_many :researches, dependent: :destroy
  has_many :relationships, dependent: :destroy
  has_many :research_groups, dependent: :destroy
  has_many :experimental_medications, dependent: :destroy

  # view
  accepts_nested_attributes_for :relationships,
                                reject_if: :all_blank, allow_destroy: true
end
