class Role < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_many :positions

	# validates :roles, :role_id, presence: true
end
