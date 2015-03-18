class Position < ActiveRecord::Base
	belongs_to :role
	belongs_to :project
	belongs_to :user
	has_many :position_requests
	has_many :applicants, through: :position_requests, class_name: 'User'

	scope :open, -> { where(user_id: nil) }

  def filled
    position.user_id != nil
  end

end
