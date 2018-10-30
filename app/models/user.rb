class User < ActiveRecord::Base
  extend Enumerize

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:username]

  belongs_to :role
  # has_and_belongs_to_many :centers
  has_many :relationships
  has_many :self_projects,class_name:"Project",foreign_key: "initiator_id"
  has_many :projects , through:  :relationships
  has_many :centers, through: :relationships

  # view
  # accepts_nested_attributes_for :relationships,
  #                               reject_if: :all_blank, allow_destroy: true

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
    self.center_name=""
    if self.centers.size==0
      "无"
    else
      self.centers.distinct.each{|c|
        self.center_name+=(c.name+"\\")
      }
    end
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



end
