class Project < ActiveRecord::Base

  belongs_to :center

  has_many :patients, dependent: :destroy
  has_many :user
  has_many :relationships, dependent: :destroy
  has_many :research_groups, dependent: :destroy
  has_many :experimental_medications, dependent: :destroy

  # view
  accepts_nested_attributes_for :relationships,
                                reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :experimental_medications,
                                reject_if: :all_blank, allow_destroy: true
  attr_accessor :groups_count
  attr_accessor :drugs_count
  attr_accessor :users_count



  def set_groups_count
    self.groups_count=self.research_groups.size
  end

  def set_drugs_count
    self.drugs_count=self.experimental_medications.size
  end

  def set_users_count
    self.users_count=self.relationships.size
  end

  def set_all_count
    self.set_drugs_count
    self.set_groups_count
    self.set_users_count
  end
end
