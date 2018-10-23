class User < ActiveRecord::Base
  extend Enumerize

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [ :username]

  # attr_accessor :current_project

  belongs_to :role
  belongs_to :center
  has_many :relationships
  has_many :projects , through:  :relationships

  # view
  accepts_nested_attributes_for :relationships,
                                reject_if: :all_blank, allow_destroy: true

  attr_accessor :projects_count
  attr_accessor :center_name

  enumerize :status, in: {
    deprecated:   0,
    in_use:       1,
  }, default: :in_use

  scope :enabled, ->{ where(status: status.find_value(:in_use).value)}

   validates :username, presence: true, uniqueness: { case_insensitive: true }, length: { in: 4..20 }





  def set_projects_count
    self.projects_count=self.relationships.size
  end

  def set_center_name
    self.center_name=self.center.name
  end

  def set_all_count
    self.set_projects_count
    self.set_center_name
  end


  def login_name
    @login_name || self.username
  end

  def login_name=(name)
    @login_name = name
  end

  def is_superintendent?
    self.role.name=="superintendent"
  end

  def any_accessable_projects?
   if self.relationships.size()!=0
     true
   else
     false
   end
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if ( login_name = conditions.delete(:login_name) )
      where('lower(username) = :val OR lower(employee_no) = :val', val: login_name).first
    else
      where(conditions).first
    end
  end


end
