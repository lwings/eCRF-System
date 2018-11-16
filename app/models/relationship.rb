class Relationship < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  belongs_to :center

  validates :project_id,presence: true
  validates :center_id,presence: true
  validates :user_id,presence: true

  attr_accessor :username
  attr_accessor :realname
  attr_accessor :centername

  def set_realname
    self.realname=self.user.realname
  end

  def set_username
    self.username=self.user.username
  end

  def set_centername
    self.centername=self.center.name
  end


end
