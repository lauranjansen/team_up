class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_one :image, as: :imageable
  has_many :skills
  has_and_belongs_to_many :roles
  has_many :owned_projects, class_name: 'Project'
  has_many :position_requests
  has_many :requested_positions, through: :position_requests, class_name: 'Position'
  has_many :positions
  has_many :team_projects, through: :positions, class_name: 'Project'
end