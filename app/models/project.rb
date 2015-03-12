class Project < ActiveRecord::Base
	has_many :images, as: :imageable
	has_many :positions
	belongs_to :owner, class_name: 'User'
	has_many :position_requests, through: :positions

  paginates_per 5

  accepts_nested_attributes_for :positions, reject_if: :all_blank, allow_destroy: true
  
end
