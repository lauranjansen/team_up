class Project < ActiveRecord::Base
	has_many :images, as: :imageable
	has_many :positions
	belongs_to :owner, class_name: 'User'
	has_many :position_requests, through: :positions

  paginates_per 5
  
end
