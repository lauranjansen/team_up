class Position < ActiveRecord::Base
	has_one :role
	belongs_to :project
	belongs_to :user
	has_many :position_requests
	has_many :applicants, through: :position_requests, class_name: 'User'

	scope :open, -> { where(user_id: nil) }
end
