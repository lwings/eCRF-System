class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable


  extend Enumerize
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [ :login_name ]

  # Associations
  # has_many :instances, through: :tasks

  belongs_to :role
  belongs_to :center
  has_many :projects , through:  :relationships

  # Enum
  # enumerize :role, in: [:superadmin, :admin, :user, :moderator], predicates: true, scope: true
  enumerize :status, in: {
    deprecated:   0,
    in_use:       1,
  }, default: :in_use

  scope :enabled, ->{ where(status: status.find_value(:in_use).value)}

  # Validation TODO: the length of employee_no
  validates :employee_no, presence: true, uniqueness: { case_insensitive: true }, length: { in: 4..20 }
  validates :username, presence: true, uniqueness: { case_insensitive: true }, length: { in: 4..20 }

  def login_name
    @login_name || self.username || self.employee_no
  end

  def login_name=(name)
    @login_name = name
  end

  ## override for sign_in_key
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if ( login_name = conditions.delete(:login_name) )
      where('lower(username) = :val OR lower(employee_no) = :val', val: login_name).first
    else
      where(conditions).first
    end
  end

  ## override for trackable
  # def update_tracked_fields(request)
  #   EventLog.create(user: self, center: self.center, event: :sign_in) # TODO: rollback when center is nil
  #   super
  # end
end
