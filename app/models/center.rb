class Center < ActiveRecord::Base
  has_many :users, dependent: :destroy
  belongs_to :project
end
