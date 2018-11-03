class Project < ActiveRecord::Base


  belongs_to :initiator,class:"User",foreign_key: "initiator_id"
  has_many :patients, dependent: :destroy
  has_many :users, through:  :relationships
  has_many :relationships, dependent: :destroy
  has_many :research_groups, dependent: :destroy
  has_many :experimental_medications, dependent: :destroy
  has_many :centers, through: :center_project_relationships
  has_many :center_project_relationships


  # view
  accepts_nested_attributes_for :relationships,
                                reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :experimental_medications,
                                reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :center_project_relationships,
                                reject_if: :all_blank, allow_destroy: true
  attr_accessor :groups_count
  attr_accessor :drugs_count
  attr_accessor :users_count


  validates :name,presence: true,uniqueness: true
  validates_associated :relationships
  validates_associated :center_project_relationships
  validates_associated :experimental_medications


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
